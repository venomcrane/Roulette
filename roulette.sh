#!/bin/bash 

#Colours
redColour="\033[1;31m"
blueColour="\033[1;34m"
yellowColour="\033[1;33m"
purpleColour="\033[1;35m"
turquoiseColour="\033[1;36m"
grayColour="\033[1;37m"
greenColour="\033[1;32m"
endColour="\033[0m"

function ctrl_c(){
  echo -e "\n\n${redColour}[!] Leaving...${endColour}"
  tput cnorm; exit 1
  
}


function banner(){
  echo -e "${purpleColour}"
  cat << 'EOF'
 ______    ______   __  __   __       ______   _________  _________  ______      
/_____/\  /_____/\ /_/\/_/\ /_/\     /_____/\ /________/\/________/\/_____/\     
\:::_ \ \ \:::_ \ \\:\ \:\ \\:\ \    \::::_\/_\__.::.__\/\__.::.__\/\::::_\/_    
 \:(_) ) )_\:\ \ \ \\:\ \:\ \\:\ \    \:\/___/\  \::\ \     \::\ \   \:\/___/\   
  \: __ `\ \\:\ \ \ \\:\ \:\ \\:\ \____\::___\/_  \::\ \     \::\ \   \::___\/_  
   \ \ `\ \ \\:\_\ \ \\:\_\:\ \\:\/___/\\:\____/\  \::\ \     \::\ \   \:\____/\ 
    \_\/ \_\/ \_____\/ \_____\/ \_____\/ \_____\/   \__\/      \__\/    \_____\/ 

                                 -=[ by r4venn_ ]=-
EOF
  echo -e "${endColour}"
}

function martingala(){
  banner | lolcat 
  echo -e "===================[::] Using Martingala Technique  [::]======================" | lolcat
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Current Money:${endColour} ${greenColour}\$$money${endColour}"
  echo -ne "${yellowColour}[+]${endColour} ${grayColour}How much money do you want to bet:${endColour} " && read inital_bet

  if ! [[ "$inital_bet" =~ ^[0-9]+$ ]]; then 
    echo -e "\n${redColour}[!] You have to select a number!${endColour}"
    exit 1
  fi

  echo -ne "${yellowColour}[+]${endColour} ${grayColour}Choise (even/odd):${endColour} " && read even_odd

  even_odd=$(echo "$even_odd" | tr '[:upper:]' '[:lower:]')

  if [[ "$even_odd" != "even" && "$even_odd" != "odd" ]]; then
    echo -e "\n${redColour}[!] You have to select even/odd${endColour} "
    exit 1 
  fi 
  
  echo -e "\n${blueColour}========== ${endColour}${yellowColour}[+]${endColour} ${grayColour}Initial amount of money${endColour} ${greenColour}\$$money${endColour} ${grayColour}to${endColour} ${purpleColour}$even_odd${endColour}${blueColour} ==========${endColour}\n"

  backup_bet=$inital_bet
  play_counter=1
  max_money=$money
  bad_plays="[ "


  tput civis # ocultar cursor
  while true; do
    #echo -e "\n${yellowColour}[+]${endColour} ${grayColour}You bet${endColour} ${greenColour}\$$inital_bet${endColour}"

    # Apostar: se descuenta el dinero al hacer la apuesta
    money=$((money - inital_bet))
    #echo -e "${yellowColour}[+]${endColour}${grayColour} You now have:${endColour} ${greenColour}\$$money${endColour}"

    # Número aleatorio (0-36)
    random_number=$((RANDOM % 37))
    #echo -e "${yellowColour}[+]${endColour} ${grayColour}Number${endColour} ${blueColour}$random_number${endColour} ${grayColour}is out!${endColour}"
    

    # Verificar si hay dinero suficiente para continuar
    if [[ $money -le 0 ]]; then
      echo -e "${redColour}[!] At the end you're out of money.${endColour}" | boxes -d stone 
      echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Your highest amount of money was:${endColour} ${greenColour}\$$max_money${endColour}"
      echo -e "\n${yellowColour}[-]${endColour} ${grayColour}Consecutive bad plays:${endColour} ${redColour}$bad_plays${endColour}\n" 
      echo -e "${blueColour}========== ${endColour}${yellowColour}[+]${endColour} ${grayColour}Total plays:${endColour} ${turquoiseColour}$play_counter${endColour}${blueColour} ==========${endColour}"

      tput cnorm; exit 0
    fi

    # Evaluar resultado
    if [[ "$even_odd" == "even" ]]; then
      if [[ $random_number -eq 0 ]]; then
        #echo -e "${redColour}[!] It's 0 — House wins.${endColour}"
        inital_bet=$((inital_bet * 2))  # duplicar apuesta para siguiente ronda
        bad_plays+="$random_number "
      elif [[ $((random_number % 2)) -eq 0 ]]; then
        #echo -e "${greenColour}[+] It's EVEN — You WIN!${endColour}"
        reward=$((inital_bet * 2))
        money=$((money + reward))
        if [[ $money -gt $max_money ]]; then 
          max_money=$money
        fi 
        #echo -e "${yellowColour}[+]${endColour} ${grayColour}New balance:${endColour} ${greenColour}\$$money${endColour}" | boxes -d stone
        inital_bet=$backup_bet  # volver a la apuesta original
        bad_plays=""
      else
        #echo -e "${redColour}[-] It's ODD — You LOSE.${endColour}"
        inital_bet=$((inital_bet * 2))  # duplicar apuesta
        bad_plays+="$random_number "
        #echo -e "${yellowColour}[+]${endColour} ${grayColour}New balance:${endColour} ${redColour}\$$money${endColour}" | boxes -d stone 
      fi

    elif [[ "$even_odd" == "odd" ]]; then
      if [[ $random_number -eq 0 ]]; then
        #echo -e "${redColour}[!] It's 0 — House wins.${endColour}"
        inital_bet=$((inital_bet * 2))
        bad_plays+="$random_number "
      elif [[ $((random_number % 2)) -ne 0 ]]; then
        #echo -e "${greenColour}[+] It's ODD — You WIN!${endColour}"
        reward=$((inital_bet * 2))
        money=$((money + reward))
        if [[ $money -gt $max_money ]]; then
          max_money=$money
        fi 
        #echo -e "${yellowColour}[+]${endColour} ${grayColour}New balance:${endColour} ${greenColour}\$$money${endColour}" | boxes -d stone
        inital_bet=$backup_bet
        bad_plays=""
      else
        #echo -e "${redColour}[-] It's EVEN — You LOSE.${endColour}"
        inital_bet=$((inital_bet * 2))
        bad_plays+="$random_number "
      fi
    fi 
    let play_counter+=1
  done
  tput cnorm # restaurar cursor  
}

function inverseLabrouchere(){
  banner | lolcat
  echo -e "===================[::] Using Inverse Labouchère Technique 🎲 [::]======================" | lolcat
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Current Money:${endColour} ${greenColour}\$$money${endColour}"
  echo -ne "${yellowColour}[+]${endColour} ${grayColour}How much money do you want to bet initially:${endColour} " && read initial_bet

  if ! [[ "$initial_bet" =~ ^[0-9]+$ ]]; then 
    echo -e "\n${redColour}[!] You have to input a number!${endColour}"
    exit 1
  fi

  echo -ne "${yellowColour}[+]${endColour} ${grayColour}Choose (even/odd):${endColour} " && read even_odd
  even_odd=$(echo "$even_odd" | tr '[:upper:]' '[:lower:]')

  if [[ "$even_odd" != "even" && "$even_odd" != "odd" ]]; then
    echo -e "\n${redColour}[!] Invalid choice. Use even or odd.${endColour}"
    exit 1
  fi

  declare -a sequence=(1 2 3 4)
  echo -e "${yellowColour}[+]${endColour} ${grayColour}Starting sequence:${endColour} ${purpleColour}[${sequence[@]}]${endColour}"
  
  bet=$((${sequence[0]} + ${sequence[-1]}))
  total_plays=0
  target_money=$((money + 50))

  tput civis
  while true; do
    let total_plays+=1
    random_number=$((RANDOM % 37))
    money=$((money - bet))

    if [[ $money -le 0 ]]; then
      echo -e "\n${redColour}[!] You're out of money.${endColour}"
      echo -e "${yellowColour}[+]${endColour} ${grayColour}Total plays:${endColour} ${turquoiseColour}$total_plays${endColour}"
      echo -e "${yellowColour}[+]${endColour} ${grayColour}Maximum threshold reached:${endColour} ${greenColour}\$$((target_money - 50))${endColour}"
      tput cnorm; exit 0
    fi

    echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Investing:${endColour} ${greenColour}\$$bet${endColour}"
    echo -e "${yellowColour}[+]${endColour} ${grayColour}Remaining money:${endColour} ${greenColour}\$$money${endColour}"
    echo -e "${yellowColour}[+]${endColour} ${grayColour}Roulette result:${endColour} ${purpleColour}$random_number${endColour}"

    win_condition=false
    if [[ "$even_odd" == "even" && $random_number -ne 0 && $((random_number % 2)) -eq 0 ]]; then
      win_condition=true
    elif [[ "$even_odd" == "odd" && $random_number -ne 0 && $((random_number % 2)) -ne 0 ]]; then
      win_condition=true
    fi

    if $win_condition; then
      echo -e "${greenColour}[+] You WIN!${endColour}"
      reward=$((bet * 2))
      money=$((money + reward))

      sequence+=($bet)
      echo -e "${yellowColour}[+]${endColour} ${grayColour}New sequence:${endColour} ${purpleColour}[${sequence[@]}]${endColour}"

      if [[ ${#sequence[@]} -gt 1 ]]; then
        bet=$((${sequence[0]} + ${sequence[-1]}))
      else
        bet=${sequence[0]}
      fi

      if [[ $money -gt $target_money ]]; then
        target_money=$((target_money + 50))
        echo -e "${yellowColour}[+]${endColour} ${grayColour}Target increased to:${endColour} ${greenColour}\$$target_money${endColour}"
        sequence=(1 2 3 4)
        echo -e "${yellowColour}[+]${endColour} ${grayColour}Sequence reset to:${endColour} ${purpleColour}[${sequence[@]}]${endColour}"
        bet=$((${sequence[0]} + ${sequence[-1]}))
      fi
    else
      echo -e "${redColour}[-] You LOSE.${endColour}"
      unset sequence[0]
      unset sequence[-1] 2>/dev/null
      sequence=(${sequence[@]})

      if [[ ${#sequence[@]} -gt 1 ]]; then
        bet=$((${sequence[0]} + ${sequence[-1]}))
      elif [[ ${#sequence[@]} -eq 1 ]]; then
        bet=${sequence[0]}
      else
        echo -e "${redColour}[!] Sequence lost. Resetting...${endColour}"
        sequence=(1 2 3 4)
        echo -e "${yellowColour}[+]${endColour} ${grayColour}Sequence reset to:${endColour} ${purpleColour}[${sequence[@]}]${endColour}"
        bet=$((${sequence[0]} + ${sequence[-1]}))
      fi
    fi
  done
  tput cnorm
}



function help_Panel(){
  banner | lolcat 
  echo -e "\n\n${yellowColour}[+]${endColour} ${grayColour}Usage:${endColour} ${purpleColour}$0${endColour}\n"
  echo -e "\t${blueColour}m)${endColour}${grayColour} Money you want to play${endColour}"
  echo -e "\t${blueColour}t)${endColour}${grayColour} Indicate technique${endColour} ${purpleColour} (${endColour}${yellowColour}martingala/inverseLabrouchere${endColour}${purpleColour}) ${endColour}"
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Examples:${endColour} "
  echo -e "\t ${greenColour}$0 -m 1000 -t martingala${endColour}"
  echo -e "\t ${greenColour}$0 -m 1000 -t inverseLabrouchere${endColour}"

  

}

#Ctrl C 
trap ctrl_c INT 

while getopts "m:t:h" arg; do 
  case $arg in 
    m) money=$OPTARG;; 
    t) technique=$OPTARG;;
    h) help_Panel;;

  esac 
done 

if [ $money ] && [ $technique ]; then
  if [ "$technique" == "martingala" ]; then 
    martingala
  elif [ "$technique" == "inverseLabrouchere" ]; then 
    inverseLabrouchere
  else 
    echo -e "\n${redColour}[!] The introduced technique does not exist${endColour}"
    sleep 1 
    help_Panel
  fi 
else 
  help_Panel
fi

