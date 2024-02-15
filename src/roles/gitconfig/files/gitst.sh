#!/usr/bin/env bash

find . -name .git | while read ligne
do
    repo=$(echo "$ligne" | sed "s#\.git##g")
    cd "$repo"
        st=$(git status -s)
        if [ "$st" != "" ]
        then
            echo "$repo"
        fi
    cd - > /dev/null 2>&1
done
