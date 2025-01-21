#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Uso: $0 <archivo_de_urls>"
    exit 1
fi

input="$1"

if [ ! -f "$input" ]; then
    echo "El archivo $input no existe."
    exit 1
fi

if [ ! -r "$input" ]; then
    echo "El archivo $input no se puede leer."
    exit 1
fi

while IFS= read -r url; do
  if [ -n "$url" ]; then
    http_status=$(curl -o /dev/null -s -w "%{http_code}" --max-time 3 "$url")
    if [ "$http_status" -eq 200 ] || [ "$http_status" -eq 301 ]; then
      echo "$url is active."
    fi
  fi
done < "$input"
