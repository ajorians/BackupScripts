#!/bin/bash

rm cookie.txt
rm *.tar.gz

piholepass=`cat /root/passwords/pihole.txt`
piholeurl="http://192.168.0.3"
downloadfilename="pihole.$(date +%F_%R).tar.gz"

echo "Navigating to $piholeurl..."
echo "Using Password: $piholepass"

curl "$piholeurl/admin/login.php" \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H "Origin: $piholeurl" \
  -H "Referer: $piholeurl/admin/login.php" \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
  --cookie-jar "cookie.txt" \
  --data-raw "pw=$piholepass" \
  --compressed \
  --insecure

output=`curl "$piholeurl/admin/settings.php" \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Connection: keep-alive' \
  -H "Referer: $piholeurl/admin/settings.php?tab=sysadmin" \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
  --cookie "cookie.txt" \
  --compressed \
  --insecure`

#echo "$output" | grep -i token

token=`echo "$output" | grep -oP "(?<=<div id=\"token\" hidden>).*(?=</div>)"`

echo "Using token: $token"

curl "$piholeurl/admin/scripts/pi-hole/php/teleporter.php" \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryahlzjBylymKV92WA' \
  -H "Origin: $piholeurl" \
  -H "Referer: $piholeurl/admin/settings.php?tab=teleporter" \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36' \
  --cookie "cookie.txt" \
  -o "$downloadfilename" \
  --data-raw $'------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="token"\r\n\r\n'"$token"$'\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="whitelist"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="regex_whitelist"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="blacklist"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="regexlist"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="adlist"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="client"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="group"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="auditlog"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="staticdhcpleases"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="localdnsrecords"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="localcnamerecords"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="zip_file"; filename=""\r\nContent-Type: application/octet-stream\r\n\r\n\r\n------WebKitFormBoundaryahlzjBylymKV92WA\r\nContent-Disposition: form-data; name="flushtables"\r\n\r\ntrue\r\n------WebKitFormBoundaryahlzjBylymKV92WA--\r\n' \
  --compressed \
  --insecure

