#!/bin/bash

ENV_NAME="venv"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/conf.cfg"

[ -f "$CONFIG_FILE" ] && source "$CONFIG_FILE"
source "$SCRIPT_DIR/language.sh"
set_language

if [ ! -d "$ENV_NAME" ]; then
  if [[ "$LANG" == "en" ]]; then
    echo "❌ Environment '$ENV_NAME' not found"  
  else
    echo "❌ El entorno '$ENV_NAME' no existe"
  fi
  exit 1
fi

source "$ENV_NAME/bin/activate"

if [[ "$LANG" == "en" ]]; then
  echo "$MSG_PIP_UPDATING"
  python -m pip install --upgrade pip >/dev/null 2>&1
  echo "$MSG_PIP_UPDATED"
else
  echo "$MSG_PIP_ACTUALIZANDO"
  python -m pip install --upgrade pip >/dev/null 2>&1
  echo "$MSG_PIP_ACTUALIZADO"
fi
