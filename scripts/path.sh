#!/bin/bash

function estado_entorno() {
  local project_dir="$1"
  local env_name="$2"
  if [[ "$VIRTUAL_ENV" != "" ]]; then
    echo -e "$MSG_ENV_ACTIVE \e[1m$VIRTUAL_ENV\e[0m"
  elif [ -d "$project_dir/$env_name" ]; then
    echo -e "$MSG_ENV_DETECTED \e[1m$project_dir/$env_name\e[0m"
  else
    echo -e "$MSG_ENV_NONE \e[1m$project_dir/$env_name\e[0m"
  fi
  echo -e "📁 $project_dir"
}

function list_files() {
  cd "$PROJECT_DIR"
  echo ""
  ls -lah --color=auto
  pause
}

function run_script() {
  cd "$PROJECT_DIR"
  if [ ! -d "$PROJECT_DIR/$ENV_NAME" ]; then
    echo "$MSG_NO_VENV_CREATE"
    read -p "(s/n): " crear
    if [[ "$crear" =~ ^[sSyY]$ ]]; then
      bash "$SCRIPT_DIR/createvenv.sh"
    else
      echo "$MSG_INVALID"
      pause
      return
    fi
  fi
  if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "$MSG_NO_VENV_ACTIVATE"
    read -p "(s/n): " activar
    if [[ "$activar" =~ ^[sSyY]$ ]]; then
      source "$PROJECT_DIR/$ENV_NAME/bin/activate"
    else
      echo "$MSG_INVALID"
      pause
      return
    fi
  fi
  if [[ "$LANG" == "en" ]]; then
    echo "You can use relative paths (e.g.: folder1/folder2/main.py)"
    read -p "Script path to execute (default: main.py): " script
  else
    echo "Puede usar rutas relativas (ej: folder1/folder2/main.py)"
    read -p "Ruta del script a ejecutar (default: main.py): " script
  fi
  script=${script:-main.py}

  script_full_path="$PROJECT_DIR/$script"
  script_dir=$(dirname "$script_full_path")
  
  if [ -f "$script_full_path" ]; then
    if [[ "$LANG" == "en" ]]; then
      echo "▶️ Running $script..."
    else
      echo "▶️ Ejecutando $script..."
    fi
    cd "$script_dir"
    python "$(basename "$script_full_path")"
    cd "$PROJECT_DIR"
  else
    if [[ "$LANG" == "en" ]]; then
      echo "❌ File '$script' not found"
    else
      echo "❌ No se encontró el archivo '$script'"
    fi
  fi
  pause
}