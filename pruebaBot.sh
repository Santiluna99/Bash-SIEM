#!/bin/bash

# Ruta al archivo de registro de autenticación
LOG_FILE="/var/log/auth.log"

# Ruta al archivo temporal que almacena la última línea procesada
LAST_LINE_FILE="/tmp/last_line.txt"

# Patrón para buscar intentos de inicio de sesión fallidos
PATTERN="incorrect password"

# Buscar intentos de inicio de sesión fallidos en el archivo de registro
FAILED_LOGINS=$(strings "$LOG_FILE" | grep "$PATTERN")

# Token del bot de Telegram
TOKEN="7153902856:AAFuyErx3lMEswAmLBBIBbWXIZjHN2-MTEU"

# ID del chat de Telegram al que se enviará el mensaje
CHAT_ID="-4173191777"
MESSAGE="Lord Senior Santiago, intentan hackearte!!!"
# Verificar si se encontraron intentos de inicio de sesión fallidos
if [ -n "$FAILED_LOGINS" ]; then

    # Si se encontraron intentos de inicio de sesión fallidos, enviar una alerta a Telegram
    curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MESSAGE" > /dev/null
fi

# Actualizar el archivo de la última línea con la línea actual
echo "$(wc -l < "$LOG_FILE")" > "$LAST_LINE_FILE"

# Salida de depuración (opcional)
echo "Análisis de registros de eventos completado en: $(date +"%Y-%m-%d %H:%M:%S")"

