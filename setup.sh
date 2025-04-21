#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Select your language / Seleccione su idioma:${NC}"
echo "1. English"
echo "2. Español"
read -p "Enter option (1/2): " lang_choice

if [ "$lang_choice" = "1" ]; then
    MSG_INSTALLING="🚀 Installing VENVMNU..."
    MSG_PERMISSIONS="📝 Setting permissions..."
    MSG_CONFIGURING="🔧 Configuring shell..."
    MSG_ADDED_ALIAS="✅ Added VENVMNU alias to"
    MSG_NO_CONFIG="⚠️  Could not find shell config file. Adding alias manually..."
    MSG_CREATING_SYMLINK="🔒 Creating system-wide command (requires sudo)..."
    MSG_SYMLINK_SUCCESS="✅ Created system-wide 'vmnu' command"
    MSG_SYMLINK_FAIL="⚠️  Could not create system-wide command. Alias will still work."
    MSG_SUCCESS="✅ VENVMNU installed successfully!"
    MSG_RESTART="ℹ️  Please restart your terminal or run 'source ~/.bashrc' (or your shell's config) to use VENVMNU"
    MSG_USAGE="🚀 You can now use VENVMNU by typing 'vmnu' anywhere in your terminal"
else
    MSG_INSTALLING="🚀 Instalando VENVMNU..."
    MSG_PERMISSIONS="📝 Configurando permisos..."
    MSG_CONFIGURING="🔧 Configurando shell..."
    MSG_ADDED_ALIAS="✅ Alias de VENVMNU añadido a"
    MSG_NO_CONFIG="⚠️  No se encontró archivo de configuración. Añadiendo alias manualmente..."
    MSG_CREATING_SYMLINK="🔒 Creando comando global (requiere sudo)..."
    MSG_SYMLINK_SUCCESS="✅ Comando global 'vmnu' creado exitosamente"
    MSG_SYMLINK_FAIL="⚠️  No se pudo crear el comando global. El alias seguirá funcionando."
    MSG_SUCCESS="✅ ¡VENVMNU instalado exitosamente!"
    MSG_RESTART="ℹ️  Por favor reinicie su terminal o ejecute 'source ~/.bashrc' (o su configuración de shell) para usar VENVMNU"
    MSG_USAGE="🚀 Ahora puede usar VENVMNU escribiendo 'vmnu' en cualquier terminal"
fi

echo -e "${GREEN}${MSG_INSTALLING}${NC}"

INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${YELLOW}${MSG_PERMISSIONS}${NC}"
chmod +x "$INSTALL_DIR/venvmnu.sh"
chmod +x "$INSTALL_DIR/scripts/"*.sh 2>/dev/null || true

ALIAS_CMD="alias vmnu='bash $INSTALL_DIR/venvmnu.sh'"

add_to_shell_config() {
    local config_file="$1"
    if [ -f "$config_file" ]; then
        if ! grep -q "alias vmnu=" "$config_file"; then
            echo -e "\n# VENVMNU alias" >> "$config_file"
            echo "$ALIAS_CMD" >> "$config_file"
            return 0
        fi
    fi
    return 1
}

echo -e "${YELLOW}${MSG_CONFIGURING}${NC}"
SHELL_UPDATED=false

CONFIGS=("$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.bash_profile")

for config in "${CONFIGS[@]}"; do
    if add_to_shell_config "$config"; then
        SHELL_UPDATED=true
        echo -e "${GREEN}${MSG_ADDED_ALIAS} $config${NC}"
    fi
done

if [ "$SHELL_UPDATED" = false ]; then
    echo -e "${YELLOW}${MSG_NO_CONFIG}${NC}"
    echo -e "\n# VENVMNU alias" >> "$HOME/.bashrc"
    echo "$ALIAS_CMD" >> "$HOME/.bashrc"
fi

echo -e "${YELLOW}${MSG_CREATING_SYMLINK}${NC}"
if sudo ln -sf "$INSTALL_DIR/venvmnu.sh" /usr/local/bin/vmnu; then
    echo -e "${GREEN}${MSG_SYMLINK_SUCCESS}${NC}"
else
    echo -e "${YELLOW}${MSG_SYMLINK_FAIL}${NC}"
fi

source "$HOME/.bashrc" 2>/dev/null || source "$HOME/.zshrc" 2>/dev/null || source "$HOME/.bash_profile" 2>/dev/null

echo -e "${GREEN}${MSG_SUCCESS}${NC}"
echo -e "${YELLOW}${MSG_RESTART}${NC}"
echo -e "${GREEN}${MSG_USAGE}${NC}"

