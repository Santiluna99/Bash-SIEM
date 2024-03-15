# Crear Bot de telegram

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
