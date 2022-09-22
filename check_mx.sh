#!/bin/bash

domain="$1"

if ! grep -q -- "${domain}" no_mx.txt && ! grep -q -- "${domain}" mx.txt; then
    if host -t MX -- "${domain}" | grep -q 'is handled by'; then
        flock -x -w 10 mx.txt echo "${domain}" >> mx.txt
    else
        flock -x -w 10 no_mx.txt echo "${domain}" >> no_mx.txt
    fi
fi
