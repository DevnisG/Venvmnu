#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Select your language / Seleccione su idioma:${NC}"
echo "1. English"
echo "2. Español"
read -p "Enter option (1/2): " lang_choice

if [ "$lang_choice" = "1" ]; then
    MSG_UNINSTALLING="🗑️  Uninstalling VENVMNU..."
    MSG_REMOVING_ALIAS="📝 Removing aliases..."
    MSG_REMOVING_SYMLINK="🔒 Removing system-wide command..."
    MSG_SUCCESS="✅ VENVMNU uninstalled successfully!"
    MSG_RESTART="ℹ️  Please restart your terminal to complete the uninstallation"
    MSG_CONFIRM="Are you sure you want to uninstall VENVMNU? (y/n): "
else
    MSG_UNINSTALLING="🗑️  Desinstalando VENVMNU..."
    MSG_REMOVING_ALIAS="📝 Eliminando aliases..."
    MSG_REMOVING_SYMLINK="🔒 Eliminando comando global..."
    MSG_SUCCESS="✅ ¡VENVMNU desinstalado exitosamente!"
    MSG_RESTART="ℹ️  Por favor reinicie su terminal para completar la desinstalación"
    MSG_CONFIRM="¿Está seguro que desea desinstalar VENVMNU? (s/n): "
fi

read -p "${MSG_CONFIRM}" confirm
if [ "$lang_choice" = "1" ]; then
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    if [[ ! "$confirm" =~ ^[Ss]$ ]]; then
        exit 1
    fi
fi

echo -e "${YELLOW}${MSG_UNINSTALLING}${NC}"

echo -e "${YELLOW}${MSG_REMOVING_ALIAS}${NC}"
CONFIGS=("$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.bash_profile")

for config in "${CONFIGS[@]}"; do
    if [ -f "$config" ]; then
        sed -i '/# VENVMNU alias/d' "$config"
        sed -i '/alias vmnu=/d' "$config"
    fi
done

echo -e "${YELLOW}${MSG_REMOVING_SYMLINK}${NC}"
if [ -f "/usr/local/bin/vmnu" ]; then
    sudo rm -f /usr/local/bin/vmnu
fi

echo -e "${GREEN}${MSG_SUCCESS}${NC}"
echo -e "${YELLOW}${MSG_RESTART}${NC}"