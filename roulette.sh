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


function banner() {
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
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Current Money:${endColour} ${greenColour}\$$money${endColour}"
  echo -ne "${yellowColour}[+]${endColour} ${grayColour}How much money do you want to bet:${endColour} " && read inital_bet
  echo -ne "${yellowColour}[+]${endColour} ${grayColour}Choise (even/odd):${endColour} " && read even_odd
  if [ "$even_odd" != "even" || "odd" ]; then 
    echo -e "\n[!] You have to select even/odd "
    exit 1 
  else 
    continue
  fi 
  
  echo -e "${yellowColour}[+]${endColour} ${grayColour}Initial amount of money${endColour} ${greenColour}\$$inital_bet${endColour} ${grayColour}to${endColour} ${purpleColour}$even_odd${endColour}"
 
  tput civis #oculta el cursor
  while true; do
    random_number="$(($RANDOM % 37))"
    echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Number${endColour} ${blueColour}$random_number${endColour} ${grayColour}is out!${endColour}"


    if [ "$even_odd" == "even" ]; then 

      if [ "$(($random_number % 2))" -eq 0 ]; then
        if [ "$random_number" -eq 0 ]; then
          echo -e "${redColour}[!] The number 0 is out so you lose${endColour}"
        else 
        echo -e "${greenColour}[+] The number that is out is even${endColour} ${yellowColour} You WIN! ${endColour}"
        fi 
      else
        echo -e "${purpleColour}[+] The number that is out is odd${endColour}"
      fi 
      sleep 10
    fi 
    done 

  tput cnorm #recuperamos el cursor
}


function help_Panel(){
  banner | lolcat 
  echo -e "\n\n${yellowColour}[+]${endColour} ${grayColour}Usage:${endColour} ${purpleColour}$0${endColour}\n"
  echo -e "\t${blueColour}m)${endColour}${grayColour} Money you want to play${endColour}"
  echo -e "\t${blueColour}t)${endColour}${grayColour} Indicate technique${endColour} ${purpleColour} (${endColour}${yellowColour}martingala/inverseLabrouchere${endColour}${purpleColour}) ${endColour}"
  echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Examples:${endColour} "
  echo -e "\t ${greenColour}$0 -m 1000 -t martingala${endColour}"
  

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
  else 
    echo -e "\n${redColour}[!] The introduced technique does not exist${endColour}"
    sleep 1 
    help_Panel
  fi 
else 
  help_Panel
fi

