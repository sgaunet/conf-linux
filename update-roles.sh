#!/usr/bin/env bash
#
# This script will update already existant roles present in the directory passed as argument


dir="$1"
CWD=$(dirname "$0")
REFDIRROLE="$CWD/src/roles"

for role in $(ls "${REFDIRROLE}"); do
    echo "$role"
    r=$(basename "$role")
    if [ -d "$dir/$r" ]; then
        diff -rq "${REFDIRROLE}/$role" "$dir/$r" > /dev/null 2>&1
        rc=$?
        if [ "$rc" != "0" ]; then
            # Update
            echo "Update $dir/$r"
            rm -rf "$dir/$r"
            cp -rfp "${REFDIRROLE}/$role" "$dir"
        fi
    fi
done