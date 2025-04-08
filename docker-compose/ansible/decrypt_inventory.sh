#!/bin/bash

# Color
verde="\e[0;32m\033[1m"
rojo="\e[0;31m\033[1m"
finColor="\033[0m\e[0m"

CLIENTE=$1
ENTORNO=$2

# Comprueba que se pasen los valores correctos
if [ -z "$1" ] || [ -z "$2" ]; then
  echo -e "${rojo}Error: Debes pasar 2 parámetros${finColor}"
  echo "Uso: $0 <cliente> <entorno> "
  exit 1
fi

VAULT_PASS_FILE="vault-monitoreo-agentes-${CLIENTE}-${ENTORNO}"
ENCRYPTED_FILE="encrypted-inventory-agentes-${CLIENTE}-${ENTORNO}.yml"
DECRYPTED_FILE="inventory-agentes-${CLIENTE}-${ENTORNO}.yml"

# Verifica si el archivo encriptado existe
if [ ! -f "$ENCRYPTED_FILE" ]; then
    echo "❌ Error: No se encontró $ENCRYPTED_FILE"
    exit 1
fi

# Desencripta temporalmente para comparar
TEMP_DECRYPTED="agentes.decrypted.tmp"
ansible-vault decrypt --vault-password-file "$VAULT_PASS_FILE" "$ENCRYPTED_FILE" --output "$TEMP_DECRYPTED"

# Reemplaza el archivo existente
mv "$TEMP_DECRYPTED" "$DECRYPTED_FILE"
echo -e "✅ Archivo desencriptado guardado como ${verde}$DECRYPTED_FILE"${finColor}
