#!/bin/bash

# Ruta al archivo de registro de autenticación
LOG_FILE="/var/log/auth.log"

# Ruta al archivo temporal que almacena la última línea procesada
LAST_LINE_FILE="/tmp/last_line.txt"

# Patrón para buscar intentos de inicio de sesión fallidos
PATTERN="incorrect password\|authentication failure"

# Buscar intentos de inicio de sesión fallidos en el archivo de registro
FAILED_LOGINS=$(strings "$LOG_FILE" | grep "$PATTERN" | tail -n 5)

# Token del bot de Telegram
TOKEN="tu_token"

# ID del chat de Telegram al que se enviará el mensaje
CHAT_ID="tu_id"

# Verificar si se encontraron intentos de inicio de sesión fallidos
if [ -n "$FAILED_LOGINS" ]; then
    # Obtener la hora de las líneas que contienen "incorrect password"
    TIME_STAMPS=$(echo "$FAILED_LOGINS" | grep "$PATTERN" | awk '{print $3}')

    # Crear el mensaje de alerta con las horas de los intentos de inicio de sesión fallidos
    ALERT_MESSAGE="Se detectaron los siguientes intentos de inicio de sesión fallidos en el archivo de registro de autenticación ($LOG_FILE) a las siguientes horas: $TIME_STAMPS"

    # Enviar la alerta a Telegram
    curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$ALERT_MESSAGE" > /dev/null
fi

# Actualizar el archivo de la última línea con la línea actual
wc -l < "$LOG_FILE" > "$LAST_LINE_FILE"

# Salida de depuración (opcional)
echo "Análisis de registros de eventos completado en: $(date +"%Y-%m-%d %H:%M:%S")"

