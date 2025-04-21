#!/bin/bash

function select_project_dir() {
  if command -v zenity &> /dev/null; then
    DIR=$(zenity --file-selection --directory --title="$MSG_SELECT_PATH_TITLE" --window-icon="question" 2>/dev/null)
  else
    read -e -p "$MSG_SELECT_PATH_TITLE: " DIR
  fi
  if [ -z "$DIR" ]; then
    echo "$MSG_INVALID"
  else
    PROJECT_DIR="$DIR"
    if grep -q '^PROJECT_DIR=' "$CONFIG_FILE"; then
      sed -i "s|^PROJECT_DIR=.*|PROJECT_DIR=\"$PROJECT_DIR\"|" "$CONFIG_FILE"
    else
      echo "PROJECT_DIR=\"$PROJECT_DIR\"" >> "$CONFIG_FILE"
    fi
    reload_config
  fi
  pause
}

function install_requirements() {
  cd "$PROJECT_DIR"
  if [ -f requirements.txt ]; then
    source "$PROJECT_DIR/$ENV_NAME/bin/activate"
    if [[ "$LANG" == "en" ]]; then
      echo "📦 Installing dependencies..."
      pip install -r requirements.txt
      echo "✅ Dependencies installed successfully!"
    else
      echo "📦 Instalando dependencias..."
      pip install -r requirements.txt
      echo "✅ Dependencias instaladas correctamente!"
    fi
  else
    if [[ "$LANG" == "en" ]]; then
      echo "⚠️ requirements.txt not found."
    else
      echo "⚠️ requirements.txt no encontrado."
    fi
  fi
  pause
}