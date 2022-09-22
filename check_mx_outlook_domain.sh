#!/bin/bash

domain="$1"

if ! grep -q -- "${domain}" not_outlook_mx.txt && ! grep -q -- "${domain}" outlook_mx.txt; then
    if dig MX "${domain}" | grep 'MX' | grep 'outlook.com'; then
        flock -x -w 10 outlook_mx.txt echo "${domain}" >> outlook_mx.txt
    else
        flock -x -w 10 not_outlook_mx.txt echo "${domain}" >> not_outlook_mx.txt
    fi
fi
