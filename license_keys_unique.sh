#!/bin/sh

# figure out where we are and where we want to be
TOPSRC="$(dirname $(realpath -e $0))"
LICDIR="${TOPSRC}/licenses"

# missing licenses subdir?  that's an error
if [ ! -d "${LICDIR}" ]; then
    echo "*** unable to find licenses subdirectory" >&2
    exit 1
fi

# gather license data files (should be one, but you never know)
cd "${LICDIR}"
DBFILES="$(ls -1 *.json 2>/dev/null | xargs)"

# no license data files?  that's an error
if [ -z "${DBFILES}" ]; then
    echo "*** unable to find any license database files" >&2
    exit 1
fi

# check each license data file
RET=0

for licdb in ${DBFILES} ; do
    total="$(grep ": {" "${licdb}" | cut -d '"' -f 2 | sort | wc -l)"
    total_unique="$(grep ": {" "${licdb}" | cut -d '"' -f 2 | sort -u | wc -l)"

    if [ ! "${total}" = "${total_unique}" ]; then
        echo "*** ${licdb} contains duplicate entries:" >&2
        grep ": {" "${licdb}" | cut -d '"' -f 2 | sort | uniq -d | sed -e 's|^|*** |g'
        RET=1
    fi
done

cat ${DBFILES} | json_verify || exit 1

exit ${RET}
