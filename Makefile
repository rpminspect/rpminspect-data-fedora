#
# rpminspect-data-fedora Makefile
# David Cantrell <dcantrell@redhat.com>
#

PKG  = rpminspect-data-fedora
VER := $(shell date +%Y%m%d%H%M)

SUBDIRS = abi-checking-whitelist capabilities licenses \
          political-whitelist setuid version-whitelist

DIST_EXTRA = AUTHORS README Makefile rpminspect.conf $(PKG).spec.in

DESTDIR    ?=
DATADIR    ?= /usr/share/rpminspect
SYSCONFDIR ?= /etc/rpminspect

RPMBUILD_DIR ?= $(shell pwd)

all: spec

spec:
	sed -e 's|%%VERSION%%|$(VER)|g' < $(PKG).spec.in > $(PKG).spec

install: $(SUBDIRS)
	for d in $(SUBDIRS) ; do \
		for f in $$d/* ; do \
			install -D -m 0644 $$f $(DESTDIR)$(DATADIR)/$$d/$$(basename $$f) ; \
		done ; \
	done
	install -D -m 0644 rpminspect.conf $(DESTDIR)$(SYSCONFDIR)/rpminspect.conf

dist: all
	rm -rf $(PKG)-$(VER)
	mkdir -p $(PKG)-$(VER)
	cp -pr $(DIST_EXTRA) $(SUBDIRS) $(PKG).spec $(PKG)-$(VER)
	tar -cvf - $(PKG)-$(VER) | xz -9c > $(RPMBUILD_DIR)/$(PKG)-$(VER).tar.xz
	rm -rf $(PKG)-$(VER)

srpm: dist
	rpmbuild -bs --nodeps --define "_sourcedir $(RPMBUILD_DIR)" --define "_srcrpmdir $(RPMBUILD_DIR)" --define "_rpmdir $(RPMBUILD_DIR)" $(PKG).spec

clean:
	-rm -rf $(PKG)-$(VER)
	-rm -f $(PKG).spec
	-rm -f *.tar.xz
	-rm -f *.src.rpm
