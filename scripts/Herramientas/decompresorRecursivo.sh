#!/bin/bash

function controlC(){
  echo -e "\n\n Saliendo...\n\n"
  exit 1
  }

trap controlC INT

firstFile="data.gz"
nextFile="$(7z l data.gz | tail -n 3 | head -n 1 | awk '{print $NF}')"

7z x $firstFile &>/dev/null

while [ $nextFile ] ;do
  echo -e "\n Nuevo archivo descomprimido: $nextFile"
  7z x $nextFile &>/dev/null
  nextFile="$(7z l $nextFile 2>/dev/null | tail -n 3 | head -n 1 | awk '{print $NF}')"
done
