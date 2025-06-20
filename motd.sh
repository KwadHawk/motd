#!/bin/bash

# === COULEUR ===


# === VARIABLES ===
USER="$(whoami)"
HOSTNAME="$(hostname)"
IP="$(ip -4 addr | grep -oE 'inet [0-9.]+' | grep -v '127.0.0.1' | head -n1)"
UPTIME="$(uptime | sed 's/.*up *//;s/,.*//')"
RAM_FREE="$(free -h | awk '/Mem:/ {print $3 "/" $2}')"
DATE="$(date '+%Y-%m-%d %H:%M:%S')"
KERNEL="$(uname -r)"
TEMP_PATH="/sys/class/thermal/thermal_zone0/temp"

# === TEMPERATURE ===
if [ -f "$TEMP_PATH" ]; then
	TEMP_RAW=$(cat "$TEMP_PATH")
	TEMP_C=$((TEMP_RAW / 1000))
	[ "$TEMP_C" -ge 70 ] && TEMP_COLOR="\033[1;31m" || TEMP_COLOR="\033[1;32m"
	TEMP_DISPLAY="${TEMP_COLOR}${TEMP_C}°C\033[0m"
else
	TEMP_DISPLAY="\033[1;30mN/A\033[0m"
fi

# === NETTOYAGE TERMINAL ===
clear

# === ANIMATION ASCII ===
for frame in \
"Booting ." "Booting .." "Booting ..." \
"Initializing CORE ." "Initializing CORE .." "Initializing CORE ..." \
"Verifying IDENTITY ." "Verifying IDENTITY .." "Verifying IDENTITY ..." \
" -********************- " \
"ACCESS TO @root://iGz: GRANTED"
do
clear
echo -ne "\033[1;32m$frame\033[0m\r"
sleep 0.4
done
echo ""
echo ""

# === ASCII ART ===

echo -e "88"
echo -e ""
echo -e "88  ,adPPYb,d8 888888888   ,adPPYba,  ,adPPYba,"
echo -e "88 a8'    'Y88      a8P'  a8'     '8a I8[    ''"
echo -e "88 8b       88   ,d8P'    8b       d8  ''Y8ba,"
echo -e "88 '8a,   ,d88 ,d8'       '8a,   ,a8' aa    ]8I"
echo -e "88  ''YbbdP'Y8 888888888   ''YbbdP''  ''YbbdP''" 
echo -e "88  aa,    ,88"
echo -e "88   'Y8bbdP'"
echo ""

# === HEADER ===
echo -e ""
echo -e "\033[1;36m============================================="
echo -e "| \033[1;35mBienvenue dans le bastion d'\033[5;31miGz\033[25;36m - [SSH ACCESS GRANTED]"
echo -e "╚═════════════════════════════════════════════════╝\033[0m"
echo -e ""
echo -e "  \033[1;34m Hôte         :\033[0m $HOSTNAME"
echo -e "  \033[1;32m Utilisateur  :\033[0m $USER"
echo -e "  \033[1;33m IP LOCALE    :\033[0m $IP"
echo -e "  \033[1;36m DATE         :\033[0m $DATE"
echo -e "  \033[1;31m UPTIME       :\033[0m $UPTIME"
echo -e "  \033[1;35m KERNEL       :\033[0m $KERNEL"
echo -e "  \033[1;32m CPU TEMP     : $TEMP_DISPLAY"
echo -e "  \033[1;35m RAM LIBRE    :\033[0m $RAM_FREE"
echo -e ""
echo -e "\033[1;30m=============================================\033[0m"
echo -e "  \033[1;30mTaper \"help\" pour afficher les commandes custom"
echo -e "\033[1;30m=============================================\033[0m"
echo -e ""