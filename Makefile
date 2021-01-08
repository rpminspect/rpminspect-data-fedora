MESON_BUILD_DIR = build
topdir := $(shell realpath $(dir $(lastword $(MAKEFILE_LIST))))

# Project information (may be an easier way to get this from meson)
PROJECT_NAME = $(shell grep ^project $(topdir)/meson.build | cut -d "'" -f 2)
PROJECT_VERSION = $(shell grep version $(topdir)/meson.build | grep -E ',$$' | cut -d "'" -f 2)

# full path to release tarball and detached signature
# (this comes from a 'make release')
RELEASED_TARBALL = $(topdir)/$(MESON_BUILD_DIR)/meson-dist/$(PROJECT_NAME)-$(PROJECT_VERSION).tar.xz
RELEASED_TARBALL_ASC = $(RELEASED_TARBALL).asc

# where we keep version numbers
LATEST_VER = $(shell grep " version : " meson.build | cut -d "'" -f 2)
LATEST_TAG = $(shell git tag -l | cut -c2- | sort -n | tail -n 1)

all: setup
	ninja -C $(MESON_BUILD_DIR) -v

setup:
	meson setup $(MESON_BUILD_DIR)

check: setup
	meson test -C $(MESON_BUILD_DIR) -v

srpm:
	$(topdir)/utils/srpm.sh

new-release:
	$(topdir)/utils/release.sh -A

release:
	$(topdir)/utils/release.sh -t -p

koji: srpm
	@if [ ! -f $(RELEASED_TARBALL) ]; then \
		echo "*** Missing $(RELEASED_TARBALL), be sure to have run 'make release'" >&2 ; \
		exit 1 ; \
	fi
	@if [ ! -f $(RELEASED_TARBALL_ASC) ]; then \
		echo "*** Missing $(RELEASED_TARBALL_ASC), be sure to have run 'make release'" >&2 ; \
		exit 1 ; \
	fi
	$(topdir)/utils/submit-koji-builds.sh $(RELEASED_TARBALL) $(RELEASED_TARBALL_ASC) $$(basename $(topdir))

did-i-bumpver:
	@if [ "$(LATEST_VER)" = "$(LATEST_TAG)" ]; then\
		echo "The version in meson.build ($(LATEST_VER)) matches the latest tagged release ($(LATEST_TAG))," ; \
		echo "so you probably did not increment the version number during development." ; \
	else \
		echo "meson.build version ($(LATEST_VER)) is different than latest tagged release ($(LATEST_TAG))." ; \
	fi

clean:
	-rm -rf $(MESON_BUILD_DIR)

help:
	@echo "rpminspect-data-fedora helper Makefile"
	@echo "The source tree uses meson(1) for building and testing, but this Makefile"
	@echo "is intended as a simple helper for the common steps."
	@echo
	@echo "    all          Default target, setup tree to build and build"
	@echo "    setup        Run 'meson setup $(MESON_BUILD_DIR)'"
	@echo "    check        Run 'meson test -C $(MESON_BUILD_DIR) -v'"
	@echo "    srpm         Generate an SRPM package of the latest release"
	@echo "    release      Tag and push current tree as a release"
	@echo "    new-release  Bump version, tag, and push current tree as a release"
	@echo "    koji         Run 'make srpm' then 'utils/submit-koji-builds.sh'"
	@echo "    clean        Run 'rm -rf $(MESON_BUILD_DIR)'"
	@echo
	@echo "To build:"
	@echo "    make"
	@echo
	@echo "To run the test suite:"
	@echo "    make check"
	@echo
	@echo "Make a new release on Github:"
	@echo "    make release         # just tags and pushes"
	@echo "    make new-release     # bumps version number, tags, and pushes"
	@echo
	@echo "Submit builds:"
	@echo "    make koji            # build for all branches with build targets"
	@echo
	@echo "You can build for a subset of branches by specifying BRANCHES:"
	@echo "    env BRANCHES=\"f33 epel7\" make koji"
	@echo "By default, the koji target will build for all project branches found"
	@echo "in the repo that have corresponding koji build targets."
