#!/bin/bash

domain="$1"

if ! grep -q -- "${domain}" not_seznam_mx.txt && ! grep -q -- "${domain}" seznam_mx.txt; then
    if dig MX "${domain}" | grep 'MX' | grep 'seznam.cz'; then
        flock -x -w 10 seznam_mx.txt echo "${domain}" >> seznam_mx.txt
    else
        flock -x -w 10 not_seznam_mx.txt echo "${domain}" >> not_seznam_mx.txt
    fi
fi
