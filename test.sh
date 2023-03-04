#!/bin/bash

regex=''\
'^([a-z0-9\-]+)[\-lp1|dd1|sp1]?\.hac(\.lp1|dd1|sp1)?\.(dragons|d4c|eshop|shop)\.(nintendo\.net|n\.nintendoswitch\.cn)'\
'|^([a-z0-9\-]+)[\.\-]?(lp1|dd1|sp1)\.([a-z0-9\-\.]+)\.srv\.nintendo\.net$'\
'|^[a-z0-9\-\.]*\.nintendo\.(com|net)'\
'|^ngs-[a-f0-9]+-live\.s3\.amazonaws\.com'\
'|epicgames\.(com|dev)|sumo-services.co.uk'

domain_regex=''\
'^(((?!\-))(xn\-\-)?[a-z0-9\-_]{0,61}[a-z0-9]{1,1}\.)*(xn\-\-)?([a-z0-9\-]{1,61}|[a-z0-9\-]{1,30})\.[a-z]{2,}'

total_domains=$(grep -P "$domain_regex" $1 | wc -l)
matches=0

while IFS= read domain; do
    # Match regex and ignore DNS entries
    if grep -Pq "$regex" <<< "$domain"; then
        ((matches++))
        echo -ne "Matching domains: $matches / $total_domains\r"
    else
        if ! grep -Pq "^#|^((25[0-5]|(2[0-4]|1\d|[1-9]|)\d)\.?\b){4}" <<< "$domain"; then
            echo "Not Matched: $domain"
        fi
    fi
done < "$1"

if ((total_domains > 0)); then
  percentage=$((matches * 100 / total_domains))
else
  percentage=0
fi

echo
echo "Matched $matches out of $total_domains domains ($percentage%)"