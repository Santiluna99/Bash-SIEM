#!/bin/bash

# Ruta al archivo de registro de autenticación
LOG_FILE="/var/log/auth.log"

# Ruta al archivo temporal que almacena la última línea procesada
LAST_LINE_FILE="/tmp/last_line.txt"

# Patrón para buscar intentos de inicio de sesión fallidos
PATTERN="incorrect password\|authentication failure"

# Token del bot de Telegram
TOKEN="tu_token"

# ID del chat de Telegram al que se enviará el mensaje
CHAT_ID="tu_token"

# Función para enviar mensaje de alerta a Telegram
send_alert() {
    # Obtener la hora de las líneas que contienen "incorrect password"
    TIME_STAMPS=$(echo "$1" | grep "$PATTERN" | awk '{print $3}')

    # Crear el mensaje de alerta con las horas de los intentos de inicio de sesión fallidos
    ALERT_MESSAGE="Se detectaron los siguientes intentos de inicio de sesión fallidos en el archivo de registro de autenticación ($LOG_FILE) a las siguientes horas: $TIME_STAMPS"

    # Enviar la alerta a Telegram
    curl -s -X POST https://api.telegram.org/bot$TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$ALERT_MESSAGE" > /dev/null
}

# Bucle infinito para verificar constantemente los nuevos intentos de inicio de sesión fallidos
while true; do
    # Obtener la última línea procesada
    LAST_LINE=$(cat "$LAST_LINE_FILE" 2>/dev/null)

    # Buscar intentos de inicio de sesión fallidos en el archivo de registro desde la última línea procesada
    FAILED_LOGINS=$(sudo strings "$LOG_FILE" | tail -n +$((LAST_LINE + 1)) | grep "$PATTERN")

    # Verificar si se encontraron nuevos intentos de inicio de sesión fallidos
    if [ -n "$FAILED_LOGINS" ]; then
        # Enviar una alerta a Telegram
        send_alert "$FAILED_LOGINS"
    fi

    # Actualizar el archivo de la última línea con la línea actual
    wc -l < "$LOG_FILE" > "$LAST_LINE_FILE"

    # Esperar un tiempo antes de la próxima verificación (por ejemplo, 60 segundos)
    sleep 5
done

