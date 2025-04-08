#!/bin/bash

# Color
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

# Variables
VAULT_PASS_FILE="vault-monitoreo-agentes-${CLIENTE}-${ENTORNO}"          # Archivo con la contraseña del Vault
PLAINTEXT_FILE="inventory-agentes-${CLIENTE}-${ENTORNO}.yml"                                   # Archivo Genérico desencriptado
ENCRYPTED_FILE="encrypted-inventory-agentes-${CLIENTE}-${ENTORNO}.yml"   # Archivo Encriptado
TEMP_DECRYPTED="agentes.decrypted-${CLIENTE}-${ENTORNO}.tmp"             # Archivo Desencriptado Temporal

# Verifica si existe un archivo encriptado previo
if [ -f "$ENCRYPTED_FILE" ]; then
    echo "🔍 Comparando con el archivo encriptado anterior..."
    
    # Desencripta temporalmente para comparar
    ansible-vault decrypt --vault-password-file "$VAULT_PASS_FILE" "$ENCRYPTED_FILE" --output "$TEMP_DECRYPTED"
    
    # Muestra diferencias
    echo
    diff --suppress-common-lines --width=150 "$TEMP_DECRYPTED" "$PLAINTEXT_FILE" --side-by-side
    echo
    # Borra archivo desencriptado temporal
    rm -f "$TEMP_DECRYPTED"
    
    # Confirma Encriptación
    read -p "Esta de acuerdo con los cambios a encryptar (S/N)? " rta
    if [[ "$rta" == "S" || "$rta" == "s" ]]; then
        # Encripta el nuevo archivo
        echo "🔐 Encriptando $PLAINTEXT_FILE..."
        ansible-vault encrypt --vault-password-file "$VAULT_PASS_FILE" --output "$ENCRYPTED_FILE" "$PLAINTEXT_FILE"
        
        # Guarda copia encriptada
        echo -e "✅ Archivo encriptado guardado como ${rojo}$ENCRYPTED_FILE"${finColor}
    else
	echo "No se realizaron cambios"
	exit 1
    fi
else
    # Encripta el nuevo archivo
    echo "🔐 Encriptando $PLAINTEXT_FILE..."
    ansible-vault encrypt --vault-password-file "$VAULT_PASS_FILE" --output "$ENCRYPTED_FILE" "$PLAINTEXT_FILE"

    # Guarda copia encriptada
    echo -e "✅ Archivo encriptado guardado como ${rojo}$ENCRYPTED_FILE"${finColor}    	
fi
