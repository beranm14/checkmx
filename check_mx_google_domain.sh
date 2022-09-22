#!/bin/bash

domain="$1"

if ! grep -q -- "${domain}" not_google_mx.txt && ! grep -q -- "${domain}" google_mx.txt; then
    if dig MX "${domain}" | grep 'MX' | grep 'google.com'; then
        flock -x -w 10 google_mx.txt echo "${domain}" >> google_mx.txt
    else
        flock -x -w 10 not_google_mx.txt echo "${domain}" >> not_google_mx.txt
    fi
fi
