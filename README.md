# Crear Bot de telegram
### 1
sudo apt-get install curl

### 2
Abra Telegram y busque la cuenta BotFather.
### 3
Inicie un chat con BotFather y escriba /newbot para crear un nuevo bot.
### 4 
Siga las indicaciones e ingrese un nombre y nombre de usuario para su bot.

### 5
BotFather le proporcionará un token API único para su bot. Guarde este token, ya que lo necesitará más adelante para enviar mensajes a su bot.

### 6
Reemplace “tu_token” con el token API proporcionado por BotFather y “tu_token” con el ID del chat donde desea recibir el mensaje. Puede encontrar su ID de chat enviando un mensaje a su bot y luego usando el siguiente comando en su navegador web:
https://api.telegram.org/bot/getUpdates


## Referencia https://www.youtube.com/watch?v=Qg5BaKTW1Uw
## Referencia https://linuxscriptshub.com/send-telegram-message-linux-scripts/

# Controlar huso horario de la maquina

### 1 Consultar lista de zonas horarias
timedatectl list-timezones

### 2
set-timezone America/Argentina/San_Juan (Reemplazar por el suyo)

### 3 Verificar si se configuro
timedatectl

### 4 Ejecutar
sudo service rsyslog restart
