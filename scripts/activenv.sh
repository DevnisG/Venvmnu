#!/bin/bash

ENV_NAME="venv"
EDITOR="code"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/conf.cfg"

[ -f "$CONFIG_FILE" ] && source "$CONFIG_FILE"
source "$SCRIPT_DIR/language.sh"
set_language

if [ ! -d "$ENV_NAME" ]; then
  echo "$MSG_ENV_NOT_FOUND"
  exit 1
fi

echo "$MSG_ENV_ACTIVATING"
source "$ENV_NAME/bin/activate"
sleep 1
echo "$MSG_ENV_ACTIVATED"
echo "$MSG_EDITOR_OPENING"
$EDITOR .
echo "$MSG_EDITOR_WAITING"
wait
