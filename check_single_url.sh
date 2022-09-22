#!/bin/bash

domain="$1"
target="$2"

if ! grep -q -- "$domain" not_active_${target}_mx.txt && ! grep -q -- "$domain" active_${target}_mx.txt; then
    if [ `curl -m 10 -s -o /dev/null -w "%{http_code}" "https://${domain}/"` = "200" ] || [ `curl -m 10 -s -o /dev/null -w "%{http_code}" "https://www.${domain}/"` = "200" ] || [ `curl -m 10 -s -o /dev/null -w "%{http_code}" "http://${domain}/"` = "200" ] || [ `curl -m 10 -s -o /dev/null -w "%{http_code}" "http://www.${domain}/"` = "200" ]; then
        flock -x -w 10 active_${target}_mx.txt echo "$domain" >> active_${target}_mx.txt
    else
        flock -x -w 10 not_active_${target}_mx.txt echo "$domain" >> not_active_${target}_mx.txt
    fi
fi
