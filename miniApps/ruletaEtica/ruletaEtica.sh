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
  tput cnorm; exit 1;
}

# Ctrl+C
trap ctrl_c INT

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}${purpleColour} $0 -m -t${endColour}"
  echo -e "\t${purpleColour}-m)${endColour}${grayColour} Dinero con el que se quiere empezar a jugar${endColour}"
  echo -e "\t${purpleColour}-t)${endColour}${grayColour} Técnica que se quiere emplear (martingala/inverseLabrouchere)${endColour}"
  echo -e "\t${purpleColour}-h)${endColour}${grayColour} Mostrar el panel de ayuda${endColour}\n"
  exit 1
}

function martingala(){ 
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Se ha elegido la técnica ${endColour}${yellowColour}Martingala${endColour}"
  echo -e "${yellowColour}[+]${endColour}${grayColour} Dinero actual: ${endColour}${yellowColour}$money€${endColour}\n"

  # Controlar que el usuario mete un número correcto
  while true; do
  echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿Cuánto dinero tienes pensado apostar? -> ${endColour}" && read initial_bet
  if [ "$initial_bet" -gt 0 ] && [ "$initial_bet" -le "$money" ]; then
    break
  else
    echo -e "\n${redColour}[!] Debes introducir un número mayor que 0 y menor que el dinero que tengas\n${endColour}"
  fi

  done

  # Controlar que el usuario mete par o impar
  while true; do

    echo -ne "${endColour}${yellowColour}[+]${endColour}${grayColour} ¿A qué deseas apostar continuamente (par/impar)? -> " && read par_impar
    if [ "$par_impar" == "par" ] || [ "$par_impar" == "impar" ]; then
      break
    else
      echo -e "\n${redColour}[!] Debes elegir entre par o impar\n${endColour}"
    fi

  done

  echo -e "\n${endColour}${yellowColour}[+]${endColour} ${grayColour}Vamos a jugar con una cantidad inicial de ${endColour}${yellowColour}$initial_bet€${endColour}${grayColour} a ${endColour}${yellowColour}$par_impar${endColour}"

  tput civis

  backup_bet=$initial_bet
  play_counter=0
  jugadas_malas="[ "
  top_money=$money

  while true; do
    money=$(($money-$initial_bet))
    if [ "$money" -ge 0 ]; then
      #echo -e "\n${yellowColour}[+]${endColour}${grayColour} Acabas de apostar ${endColour}${yellowColour}$initial_bet€${endColour}${grayColour} y tienes${endColour}${yellowColour} $money€${endColour}"
      random_number="$(($RANDOM % 37))"
      #echo -e "\n${yellowColour}[+] ${endColour}${grayColour}Ha salido el número ${endColour}${yellowColour}$random_number${endColour}"

      if [ "$par_impar" == "par" ]; then
        if [ "$random_number" -eq 0 ]; then
          #echo -e "${yellowColour}[+]${endColour}${redColour} El 0 no se considera par ni impar, ¡Pierdes!${endColour}"
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Has perdido ${endColour}${yellowColour}$initial_bet€${endColour}"
          initial_bet=$(($initial_bet*2))
          jugadas_malas+="$random_number "
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$money€${endColour}"

        elif [ "$(($random_number % 2))" -eq 0 ]; then
          #echo -e "${yellowColour}[+]${endColour}${greenColour} El número que ha salido es par, ¡Ganas!${endColour}"
          reward=$(($initial_bet*2))
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Has ganado${endColour}${yellowColour} $reward€${endColour}"
          money=$(($money+$reward))
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$money€${endColour}"
          initial_bet=$backup_bet
          jugadas_malas="[ "
          if [ "$money" -gt "$top_money" ]; then
            top_money=$money
          fi

        else
          #echo -e "${yellowColour}[+]${endColour}${redColour} El número que ha salido es impar, ¡Pierdes!${endColour}"
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Has perdido ${endColour}${yellowColour}$initial_bet€${endColour}"
          initial_bet=$(($initial_bet*2))
          jugadas_malas+="$random_number "
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$money€${endColour}"
        fi

      else
         if [ "$random_number" -eq 0 ]; then
          #echo -e "${yellowColour}[+]${endColour}${redColour} El 0 no se considera par ni impar, ¡Pierdes!${endColour}"
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Has perdido ${endColour}${yellowColour}$initial_bet€${endColour}"
          initial_bet=$(($initial_bet*2))
          jugadas_malas+="$random_number "
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$money€${endColour}"

        elif [ "$(($random_number % 2))" -eq 0 ]; then
          #echo -e "${yellowColour}[+]${endColour}${redColour} El número que ha salido es par, ¡Pierdes!${endColour}"
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Has perdido ${endColour}${yellowColour}$initial_bet€${endColour}"
          initial_bet=$(($initial_bet*2))
          jugadas_malas+="$random_number "
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$money€${endColour}"

         else
          #echo -e "${yellowColour}[+]${endColour}${greenColour} El número que ha salido es impar, ¡Ganas!${endColour}"
          reward=$(($initial_bet*2))
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Has ganado${endColour}${yellowColour} $reward€${endColour}"
          money=$(($money+$reward))
          #echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$money€${endColour}"
          initial_bet=$backup_bet
          jugadas_malas="[ "
          if [ "$money" -gt "$top_money" ]; then
            top_money=$money
          fi

        fi

      fi
      let play_counter+=1
    else
      #echo -e "\n${redColour}[!] Tienes${endColour}${yellowColour} $(($money+$initial_bet))€${endColour}${redColour} y la siguiente apuesta debería ser de $initial_bet€${endColour}"
      echo -e "\n${redColour}[!] Vaya... te has quedado sin guita${endColour}\n"
      echo -e "${yellowColour}[+]${endColour}${grayColour} Han habido un total de ${endColour}${yellowColour}$play_counter${endColour}${grayColour} jugadas${endColour}"
      echo -e "${yellowColour}[+]${endColour} ${grayColour}El dinero máximo alcanzado fue de ${endColour}${yellowColour}$top_money€${endColour}"
      echo -e "${yellowColour}[+]${endColour}${grayColour} A continuación se van a mostrar las últimas jugadas malas consecutivas que se han producido...${endColour}"
      echo -e "\n${blueColour}$jugadas_malas]${endColour}\n"
      tput cnorm; exit 0 # Con el exit, se sale del while y finaliza el programa
    fi


  done

  tput cnorm
}

function inverseLabrouchere(){

  declare -a my_sequence=(1 2 3 4)
  declare -i play_counter=0
  declare -i top_money=$money

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Se ha elegido la técnica ${endColour}${yellowColour}Inverse Labrouchere${endColour}"
  echo -e "${yellowColour}[+]${endColour}${grayColour} Dinero actual: ${endColour}${yellowColour}$money€${endColour}\n"

# Controlar que el usuario mete par o impar
  while true; do

    echo -ne "${endColour}${yellowColour}[+]${endColour}${grayColour} ¿A qué deseas apostar continuamente (par/impar)? -> " && read par_impar
    if [ "$par_impar" == "par" ] || [ "$par_impar" == "impar" ]; then
      break
    else
      echo -e "\n${redColour}[!] Debes elegir entre par o impar\n${endColour}"
    fi

  done

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Se va a apostar continuamente a ${endColour}${purpleColour}$par_impar${endColour}"
  echo -e "${yellowColour}[+]${endColour}${grayColour} Comenzamos con la secuencia ${endColour}${purpleColour}[${my_sequence[@]}]${endColour}"

  tput civis

  while true; do

  # Bloque en el que se controla si la secuencia que tenemos entre manos tiene 0, 1 o más elementos

  if [ "${#my_sequence[@]}" -eq 0 ]; then

    #echo -e "\n${yellowColour}[+]${endColour}${purpleColour} Vaya... se han agotado todos los elementos de la secuencia, generando una nueva..."
    if [ "$money" -lt 15 ]; then
      echo -e "\n${redColour}[!] No manches... Te has quedado sin guita suficiente para generar una nueva secuencia... La banca simpre gana!${endColour}"
      echo -e "${redColour}[!] El dinero necesario para generar la secuencia es de ${endColour}${yellowColour}15€${endColour}${redColour} y tu tienes${endColour}${yellowColour} $money€${endColour}"
      break;

    else
      my_sequence=(1 2 3 4)
      #echo -e "${yellowColour}[+]${endColour}${purpleColour} Nueva secuencia ${purpleColour}[1 2 3 4] generada${endColour}"
      bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
      money=$(($money - $bet))

    fi

  elif [ "${#my_sequence[@]}" -eq 1 ]; then
    bet=${my_sequence[0]}
    money=$(($money - $bet))

  else
    bet=$((${my_sequence[0]} + ${my_sequence[-1]}))
    money=$(($money - $bet))

  fi
    
    #echo -e "\n${yellowColour}[+]${endColour}${grayColour} Has apostado ${endColour}${yellowColour}${bet}€${endColour}${grayColour}, quedando un saldo de ${endColour}${yellowColour}$money€${endColour}"
    random_number=$(($RANDOM % 37))
    #echo -e "${yellowColour}[+] ${endColour}${grayColour}Ha salido el número ${endColour}${blueColour}$random_number${endColour}"

    # Bloque para controlar cuando se apuesta a los números pares
    if [ "$par_impar" == "par" ]; then

        if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
          #echo -e "${yellowColour}[+]${endColour}${greenColour} El número que ha salido es par, ¡Ganas!${endColour}"
          reward=$(($bet * 2))

          #echo -e "${yellowColour}[+]${endColour}${grayColour} Has ganado${endColour}${yellowColour} $reward€${endColour}"
          let money+=reward

          my_sequence+=($bet)
          my_sequence=(${my_sequence[@]})

        else
          if [ "$(($random_number % 2))" -ne 0  ]; then
            : #echo -e "${yellowColour}[+]${endColour}${redColour} El número que ha salido es impar, ¡Pierdes!${endColour}"

          else 
            : #echo -e "${yellowColour}[+]${endColour}${redColour} El 0 no se considera par ni impar, ¡Pierdes!${endColour}"
          fi

          #echo -e "${yellowColour}[+]${endColour}${grayColour} Has perdido ${endColour}${yellowColour}$bet€${endColour}"

          if [ "${#my_sequence[@]}" -eq 1 ]; then
            unset my_sequence[0]
            my_sequence=(${my_sequence[@]})

          else
            unset my_sequence[0]
            unset my_sequence[-1]
            my_sequence=(${my_sequence[@]})
          fi

        fi
 
    # Bloque para controlar cuando se apuesta a los números impares
    else
      if [ "$(($random_number % 2))" -eq 0 ]; then
        if [ "$random_number" -eq 0 ]; then
          : #echo -e "${yellowColour}[+]${endColour}${redColour} El 0 no se considera par ni impar, ¡Pierdes!${endColour}"
        else
          : #echo -e "${yellowColour}[+]${endColour}${redColour} El número que ha salido es par, ¡Pierdes!${endColour}"
        fi

        #echo -e "${yellowColour}[+]${endColour}${grayColour} Has perdido ${endColour}${yellowColour}$bet€${endColour}"

        if [ "${#my_sequence[@]}" -eq 1 ]; then
          unset my_sequence[0]
          my_sequence=(${my_sequence[@]})

        else
          unset my_sequence[0]
          unset my_sequence[-1]
          my_sequence=(${my_sequence[@]})
        fi

      else
        #echo -e "${yellowColour}[+]${endColour}${greenColour} El número que ha salido es impar, ¡Ganas!${endColour}"
        reward=$(($bet * 2))

        #echo -e "${yellowColour}[+]${endColour}${grayColour} Has ganado${endColour}${yellowColour} $reward€${endColour}"
        let money+=reward
        my_sequence+=($bet)
        my_sequence=(${my_sequence[@]})

      fi

    fi

    #echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes ${endColour}${yellowColour}$money€${endColour}"
    #echo -e "${yellowColour}[+]${endColour}${grayColour} La nueva secuencia es:${endColour} ${purpleColour}[${my_sequence[@]}]${endColour}"
  
    let play_counter+=1

    if [ "$top_money" -lt $money ]; then
      top_money=$money
    fi

  #sleep 1

  done

  tput cnorm

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Han habido un total de ${endColour}${yellowColour}$play_counter${endColour}${grayColour} jugadas${endColour}"
  echo -e "${yellowColour}[+]${endColour} ${grayColour}El dinero máximo alcanzado fue de ${endColour}${yellowColour}$top_money€${endColour}"

}


while getopts "m:t:h" arg; do
  case $arg in
    m) money=$OPTARG;;
    t) technique=$OPTARG;;
    h) helpPanel;;
  esac
done

if [ $money ] && [ $technique ]; then
  if [ "$money" -le 0 ]; then
    echo -e "\n${redColour}[!] El dinero con el que quieres empezar no puede ser menor o igual a 0 !${endColour}"
  elif [ "$technique" == "martingala" ]; then
    martingala 
  elif [ "$technique" == "inverseLabrouchere" ]; then
    inverseLabrouchere
  else
    echo -e "\n${redColour}[!] La técnica introducida no existe, debes elegir entre martingala o inverseLabrouchere${endColour}"
  fi
else
  helpPanel
fi
