#!/bin/bash

ENV_NAME="venv"
[ -f conf.cfg ] && source <(grep = conf.cfg)

if [ -d "$ENV_NAME" ]; then
  if [[ "$LANG" == "en" ]]; then
    echo "⚠️ Environment '$ENV_NAME' already exists."
  else
    echo "⚠️ El entorno '$ENV_NAME' ya existe."
  fi
else
  if [[ "$LANG" == "en" ]]; then
    echo "🔧 Creating virtual environment '$ENV_NAME'..."
    python3 -m venv "$ENV_NAME"
    echo "✅ Environment created."
  else
    echo "🔧 Creando entorno virtual '$ENV_NAME'..."
    python3 -m venv "$ENV_NAME"
    echo "✅ Entorno creado."
  fi
fi
