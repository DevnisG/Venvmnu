#!/bin/bash

# ======== DETERMINE SCRIPT DIRECTORY =========
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/scripts/conf.cfg"

# ======== CREATE DEFAULT CONFIG IF NOT EXISTS =========
if [ ! -f "$CONFIG_FILE" ]; then
  cat <<EOF > "$CONFIG_FILE"
ENV_NAME="venv"
EDITOR="code"
DEFAULT_SCRIPT="main.py"
PROJECT_DIR="$(pwd)"
LANG="es"
EOF
fi

# ======== LOAD CONFIGURATION =========
source "$CONFIG_FILE"

# ======== LOAD MODULES =========
source "$SCRIPT_DIR/scripts/language.sh"
source "$SCRIPT_DIR/scripts/status.sh"
source "$SCRIPT_DIR/scripts/path.sh"
source "$SCRIPT_DIR/scripts/listpip.sh"

# ======== INITIALIZATION =========
set_language
reload_config

# ======== TITLE =========
function encabezado() {
  clear
  echo -e "\e[1;32m╔════════════════════════════════════════════════════════════════════════╗"
  echo -e "║                      🐍 VENVMNU - Venv Menu CLI                        ║"
  echo -e "╚════════════════════════════════════════════════════════════════════════╝\e[0m"
}

# ======== MENU =========
while true; do
  encabezado
  echo -e "\e[1;32m╔════════════════════════════════════════════════════════════════════════╗\e[0m"
  estado_entorno "$PROJECT_DIR" "$ENV_NAME"
  echo -e "\e[1;32m╚════════════════════════════════════════════════════════════════════════╝\e[0m"
  echo -e "\e[1;32m╔════════════════════════════════════════════════════════════════════════╗"
  echo -e "\e[37m S) $MENU_1"                                       
  echo -e " C) $MENU_2"                                        
  echo -e " A) $MENU_3"                                        
  echo -e " U) $MENU_4"                                                      
  echo -e " I) $MENU_5"                                           
  echo -e " F) $MENU_6"
  echo -e " R) $MENU_7"
  echo -e " E) $MENU_8"
  echo -e " L) $MENU_9"
  echo -e " P) $MENU_10"
  echo -e " X) $MENU_0"                               
  echo -e "\e[1;32m╚════════════════════════════════DEVNIS_G════════════════════════════════╝\e[0m"
  read -p "$PROMPT_OPTION: " opcion
                           
  # ======== VALIDATE OPTION =========
  case $opcion in
    [Ss]) select_project_dir;;
    [Cc]) cd "$PROJECT_DIR"; bash "$SCRIPT_DIR/scripts/createvenv.sh";    pause;;
    [Aa]) 
       cd "$PROJECT_DIR"
       source "$SCRIPT_DIR/scripts/activenv.sh"
       echo -e "\n$MSG_EDITOR_OPENED"
       pause
       ;;  
    [Uu]) cd "$PROJECT_DIR"; bash "$SCRIPT_DIR/updatevenv.sh";     pause;;  
    [Ii]) install_requirements;; 
    [Ff]) list_files;;  
    [Rr]) run_script;;  
    [Ee]) edit_config ;;
    [Ll]) change_language;;        
    [Pp]) list_pip_packages;;  
    [Xx]) echo "$MSG_GOODBYE"; exit 0;;
    *) echo "$MSG_INVALID"; sleep 1;;
  esac

# ======== END OF WHILE LOOP =========
done




