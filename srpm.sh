#!/bin/sh

PATH=/usr/bin
CWD="$(pwd)"

if [ ! -f ${CWD}/.copr/Makefile ]; then
    echo "*** Missing .copr/Makefile, exiting." >&2
    exit 1
fi

make -f ${CWD}/.copr/Makefile srpm outdir=${CWD}
