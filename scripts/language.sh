#!/bin/bash

# LANGUAGE
function set_language() {
  if [[ "$LANG" == "en" ]]; then

    # ENGLISH
    MSG_TITLE="🐍 VENVMNU - Venv Menu CLI"
    MSG_ENV_ACTIVE="🟢 Active Venv:"
    MSG_ENV_DETECTED="🟡 Venv detected but not active:"
    MSG_ENV_NONE="🔴 No Venv found:"

    # MENU
    MENU_1="Select project directory"
    MENU_2="Create virtual Venv ($ENV_NAME)"
    MENU_3="Activate venv + open $EDITOR"
    MENU_4="Update pip"
    MENU_5="Install requirements.txt"
    MENU_6="List project files"
    MENU_7="Run Python script"Venv
    MENU_8="Edit configuration"
    MENU_9="Change language (Español/English)"
    MENU_10="List pip packages"
    MENU_0="Exit"

    # PROMPT
    PROMPT_OPTION="Choose an option"
    PROMPT_ENTER="Press Enter to continue..."

    # MESSAGES
    MSG_INVALID="Invalid option"
    MSG_GOODBYE="🐍 VENVMNU - Goodbye!"
    MSG_NO_VENV_CREATE="Environment '$ENV_NAME' does not exist. Create now?"
    MSG_NO_VENV_ACTIVATE="Environment '$ENV_NAME' is not active. Activate now?"
    MSG_SELECT_PATH_TITLE="Select your project folder"
    MSG_CONF_EDIT="Opening configuration file..."
    MSG_LANG_SELECT="Select language: 1) Español  2) English"
    MSG_ENV_ACTIVATING="🔄 Activating environment..."
    MSG_ENV_ACTIVATED="✅ Environment activated successfully"
    MSG_ENV_NOT_FOUND="❌ Environment '$ENV_NAME' not found. Use option 1 first."
    MSG_EDITOR_OPENING="🚀 Opening project in $EDITOR..."
    MSG_EDITOR_WAITING="⌛ Opening $EDITOR..."
    MSG_EDITOR_OPENED="📝 $EDITOR Opened. Press ENTER to continue..."

    # PIP
    MSG_PIP_UPDATING="⬆️ Updating pip..."
    MSG_PIP_UPDATED="✅ pip successfully updated"
    MSG_PIP_ACTUALIZANDO="⬆️ Actualizando pip..."
    MSG_PIP_ACTUALIZADO="✅ pip actualizado."

    MSG_PIP_LIST="📋 List of installed pip packages:"
    
    # REQUIREMENTS
    MSG_REQ_INSTALLING="Installing dependencies..."
    MSG_REQ_NOT_FOUND="⚠️ requirements.txt not found."
    MSG_REQ_INSTALANDO="Instalando dependencias..."
    MSG_REQ_NO_ENCONTRADO="⚠️ requirements.txt no encontrado."
  else

    # ESPAÑOL
    MSG_TITLE="🐍 VENVMNU - Menú CLI Venv"
    MSG_ENV_ACTIVE="🟢 Venv activo:"
    MSG_ENV_DETECTED="🟡 Venv detectado pero no activo:"
    MSG_ENV_NONE="🔴 No hay Venv:"

    # MENU
    MENU_1="Seleccionar ruta del proyecto"
    MENU_2="Crear entorno virtual ($ENV_NAME)"
    MENU_3="Activar entorno + abrir $EDITOR"
    MENU_4="Actualizar pip"
    MENU_5="Instalar requirements.txt"
    MENU_6="Listar archivos del proyecto"
    MENU_7="Ejecutar script (.py)"
    MENU_8="Editar configuración"
    MENU_9="Cambiar idioma (Español/English)"
    MENU_10="Listar paquetes de pip"
    MENU_0="Salir"

    # PROMPT
    PROMPT_OPTION="Selecciona una opción"
    PROMPT_ENTER="Presiona Enter para continuar..."

    # MESSAGES
    MSG_INVALID="Opción inválida"
    MSG_GOODBYE="🐍 VENVMNU - ¡Adiós!"
    MSG_NO_VENV_CREATE="El entorno '$ENV_NAME' no existe. ¿Crear ahora?"
    MSG_NO_VENV_ACTIVATE="El entorno '$ENV_NAME' no está activo. ¿Activar ahora?"
    MSG_SELECT_PATH_TITLE="Selecciona la carpeta de tu proyecto"
    MSG_CONF_EDIT="Abriendo archivo de configuración..."
    MSG_LANG_SELECT="Elige idioma: 1) Español  2) English"
    MSG_ENV_ACTIVATING="🔄 Activando entorno..."
    MSG_ENV_ACTIVATED="✅ Entorno activado correctamente"
    MSG_ENV_NOT_FOUND="❌ El entorno '$ENV_NAME' no existe. Usa la opción 1 primero."
    MSG_EDITOR_OPENING="🚀 Abriendo proyecto en $EDITOR..."
    MSG_EDITOR_WAITING="⌛ Abriendo $EDITOR..."
    MSG_EDITOR_OPENED="📝 $EDITOR Abierto. Presiona ENTER para continuar..."

    # PIP
    MSG_PIP_UPDATING="⬆️ Updating pip..."
    MSG_PIP_UPDATED="✅ pip updated."
    MSG_PIP_ACTUALIZANDO="⬆️ Actualizando pip..."
    MSG_PIP_ACTUALIZADO="✅ pip actualizado correctamente"
    MSG_PIP_LIST="📋 Lista de paquetes pip instalados:"
    
    # REQUIREMENTS
    MSG_REQ_INSTALLING="Installing dependencies..."
    MSG_REQ_NOT_FOUND="⚠️ requirements.txt not found."
    MSG_REQ_INSTALANDO="Instalando dependencias..."
    MSG_REQ_NO_ENCONTRADO="⚠️ requirements.txt no encontrado."
  fi

}
function reload_config() {
  source "$CONFIG_FILE"
  set_language
}

function pause() {
  read -p "$PROMPT_ENTER"
}

function edit_config() {
  echo "$MSG_CONF_EDIT"
  if ! command -v nano &> /dev/null; then
    if command -v apt &> /dev/null; then
      sudo apt install -y nano
    elif command -v dnf &> /dev/null; then
      sudo dnf install -y nano
    elif command -v pacman &> /dev/null; then
      sudo pacman -S --noconfirm nano
    else
      echo "No se pudo encontrar o instalar nano"
      return 1
    fi
  fi
  nano "$CONFIG_FILE"
}

function change_language() {
  echo "$MSG_LANG_SELECT"
  read -p ">> " lang_opt
  if [[ "$lang_opt" == "1" ]]; then LANG="es"
  elif [[ "$lang_opt" == "2" ]]; then LANG="en"
  else
    echo "$MSG_INVALID"
    pause
    return
  fi
  sed -i "s|^LANG=.*|LANG=\"$LANG\"|" "$CONFIG_FILE"
  reload_config
}