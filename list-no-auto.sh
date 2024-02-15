#!/usr/bin/env bash

find src/roles -type f -name NO-AUTO | sed "s#NO-AUTO#defaults/main.yml#g"
