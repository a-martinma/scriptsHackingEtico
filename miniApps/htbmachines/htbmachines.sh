#!/bin/bash

#Colours 
greenColour="\e[0;32m\033[1m" 
endColour="\033[0m\e[0m" 
redColour="\e[0;31m\033[1m" 
blueColour="\e[0;34m\033[1m" 
yellowColour="\e[0;33m\033[1m" 
purpleColour="\e[0;35m\033[1m" 
turquoiseColour="\e[0;36m\033[1m" 
grayColour="\e[0;37m\033[1m"


function ctrl_c(){
  echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
  tput cnorm; exit 1
}


trap ctrl_c INT

# Variables globales
main_url="https://htbmachines.github.io/bundle.js"


function helpPanel(){

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}"
  echo -e "\t${purpleColour}u)${endColour}${grayColour} Descargar o actualizar archivos necesarios${endColour}"
  echo -e "\t${purpleColour}m)${endColour}${grayColour} Buscar por un nombre de máquina${endColour}"
  echo -e "\t${purpleColour}i)${endColour}${grayColour} Buscar por dirección IP${endColour}"
  echo -e "\t${purpleColour}d)${endColour}${grayColour} Buscar por la dificultad de una máquina${endColour}"
  echo -e "\t${purpleColour}o)${endColour}${grayColour} Buscar por el sistema operativo${endColour}"
  echo -e "\t${purpleColour}s)${endColour}${grayColour} Buscar por skill${endColour}"
  echo -e "\t${purpleColour}d & o)${endColour}${grayColour} Buscar por dificultad y sistema operativo${endColour}"
  echo -e "\t${purpleColour}y)${endColour}${grayColour} Obtener el link de Youtube de la resolución de la máquina especificada${endColour}"
  echo -e "\t${purpleColour}h)${endColour}${grayColour} Mostrar panel de ayuda${endColour}\n"

}

function updateFiles(){

    tput civis # Ocultar cursor

  if [ ! -f bundle.js ]; then # Si el archivo NO existe
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Descargando archivos necesarios...${endColour}"
    curl -s $main_url > bundle.js
    js-beautify bundle.js | sponge bundle.js
    echo -e "\n${yellowColour}[+]${endColour}${grayColour}Todos los archivos han sido descargados${endColour}"

  else
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Combrobando si hay actualizaciones pendientes...${endColour}"
    curl -s $main_url > bundle_temp.js
    js-beautify bundle_temp.js | sponge bundle_temp.js
    md5_temp_value=$(md5sum bundle_temp.js | awk '{print $1}')
    md5_original_value=$(md5sum bundle.js | awk '{print $1}')

    if [ "$md5_temp_value" == "$md5_original_value" ]; then # Se pone con == porque no es un valor numérico
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} No se han detectado actualizaciones${endColour}"
      rm bundle_temp.js

    else
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Se han encontrado actualizaciones${endColour}"
      sleep 1
      rm bundle.js && mv bundle_temp.js bundle.js
      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Los archivos han sido actualizados${endColour}"
      
    fi

  fi

    tput cnorm # Volver a mostrar el cursor
}

function searchMachine(){
  machineName="$1"

  machineNameChecker="$(cat bundle.js | awk "/name: \"$machineName\"/,/resuelta/" | grep -vE "id:|sku:|resuelta:" | tr -d '",' | sed 's/^ *//')"

  if [ "$machineNameChecker" ]; then

    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Listando las propiedades de la máquina${endColour}${blueColour} $machineName${endColour}${grayColour}:${endColour}\n"

    cat bundle.js | awk "/name: \"$machineName\"/,/resuelta/" | grep -vE "id:|sku:|resuelta:" | tr -d '",' | sed 's/^ *//'

  else
    echo -e "\n${redColour}[!] La máquina proporcionada no existe${endColour}\n"
  fi

}

function searchIP(){
  ipAddress="$1"

  machineName="$(cat bundle.js | grep "ip: \"$ipAddress\"" -B 3 | grep "name: " | awk '{print $NF}' | tr -d '",')"

  if [ "$machineName" ]; then
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} La máquina correspondiente para la IP${endColour}${blueColour} $ipAddress${endColour}${grayColour} es${endColour}${purpleColour} $machineName${endColour}"

  else
    echo -e "\n${redColour}[!] La dirección IP proporcionada no existe${endColour}\n"
  fi
}

function getYoutubeLink(){

  machineName="$1"

  youtubeLink="$(cat bundle.js | awk "/name: \"$machineName\"/,/youtube:/" | tail -n 1 | awk '{print $2}' | tr -d '",')"

  if [ "$youtubeLink" ]; then
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} El tutorial para esta máquina está en el siguiente enlace:${endColour}${blueColour} $youtubeLink${endColour}"
  else
    echo -e "\n${redColour}[!] La máquina proporcionada no existe${endColour}\n"
  fi
}

function getMachinesDifficulty(){
  difficulty=$1

  results_check="$(cat bundle.js | grep "dificultad: \"$difficulty\"" -B 5 | grep "name:" | awk '{print $NF}' | tr -d '",' | column)"

  if [ "$results_check" ]; then
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Representando las máquinas que poseen un nivel de dificultad${endColour}${blueColour} $difficulty${endColour}${grayColour}:${endColour}"
    cat bundle.js | grep "dificultad: \"$difficulty\"" -B 5 | grep "name:" | awk '{print $NF}' | tr -d '"' | tr -d ',' | column
  else
    echo -e "\n${redColour}[!] La dificultad proporcionada no existe. Elige entre Fácil, Media, Difícil o Insane${endColour}\n"
  fi

}

function getOSMachines(){
  os=$1

  os_results="$(cat bundle.js| grep "so: \"$os\"" -B 5 | grep "name: " | awk '{print $NF}' | tr -d '",' | column)"
  
  if [ "$os_results" ]; then
    echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Mostrando las máquinas cuyo sistema operativo son ${endColour}${blueColour}$os${endColour}${grayColour}: ${endColour}\n"
    cat bundle.js| grep "so: \"$os\"" -B 5 | grep "name: " | awk '{print $NF}' | tr -d '",' | column
  else 
    echo -e "\n${redColour}[!] El sistema operativo no existe. Elige entre Linux o Windows${endColour}\n"
  fi

}

function getOSDifficultyMachines(){
  difficulty=$1
  os=$2

  check_results="$(cat bundle.js | grep "so: \"$os\"" -C 4 | grep "dificultad: \"$difficulty\"" -B 5 | grep "name:" | awk '{print $NF}' | tr -d '",' | column)"

  if [ "$check_results" ]; then
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Listando máquinas de dificultad${endColour}${blueColour} $difficulty${endColour}${grayColour} cuyo sistema operativo sea${endColour}${purpleColour} $os${endColour}${grayColour}:${endColour}\n"
    cat bundle.js | grep "so: \"$os\"" -C 4 | grep "dificultad: \"$difficulty\"" -B 5 | grep "name:" | awk '{print $NF}' | tr -d '",' | column
  else
    echo -e "\n${redColour}[!] El sistema operativo o la dificultad no existe/n${endColour}\n"
  fi
}

function getSkill(){
  skill=$1

  check_skill="$(cat bundle.js| grep "skills: " -B 6 | grep "$skill" -i -B 6 | grep "name:" | awk '{print $NF}' | tr -d '",' | column)"

  if [ "$check_skill" ]; then
    echo -e "\n${yellowColour}[+]${endColour}${grayColour} Máquinas con la skill:${endColour} ${blueColour}$skill${endColour}"
    cat bundle.js| grep "skills: " -B 6 | grep "$skill" -i -B 6 | grep "name:" | awk '{print $NF}' | tr -d '",' | column
  else
    echo -e "\n${redColour}[!] No se ha encontrado ninguna máquina con la skill indicada${endColour}\n"
  fi

}

# Indicadores
declare -i parameter_counter=0

# Chivatos
declare -i chivato_difficulty=0
declare -i chivato_os=0


while getopts "um:i:y:d:o:s:h" arg; do
  case $arg in
    m) machineName=$OPTARG; parameter_counter=1;;
    u) parameter_counter=2;;
    i) ipAddress=$OPTARG; parameter_counter=3;;
    y) machineName=$OPTARG; parameter_counter=4;;
    d) difficulty=$OPTARG; chivato_difficulty=1; parameter_counter=5;;
    o) os=$OPTARG; chivato_os=1; parameter_counter=6;;
    s) skill=$OPTARG; parameter_counter=7;;
    h) ;;
  esac
done

if [ $parameter_counter -eq 1 ]; then
  searchMachine $machineName
elif [ $chivato_difficulty -eq 1 ] && [ $chivato_os -eq 1 ]; then
  getOSDifficultyMachines $difficulty $os
elif [ $parameter_counter -eq 2  ]; then
  updateFiles
elif [ $parameter_counter -eq 3 ]; then
  searchIP $ipAddress
elif [ $parameter_counter -eq 4 ]; then
  getYoutubeLink $machineName
elif [ $parameter_counter -eq 5 ]; then
  getMachinesDifficulty $difficulty
elif [ $parameter_counter -eq 6 ]; then
  getOSMachines $os
elif [ $parameter_counter -eq 7 ]; then
    getSkill "$skill"
else
  helpPanel
fi
