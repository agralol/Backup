#!/bin/bash

# Скрипт резервного копирования домашней директории
# Chernov

SOURCE="/home/chernov/"
DEST="/tmp/backup/"
LOG_TAG="backup_script"

# Создаём целевую директорию, если не существует
mkdir -p "$DEST"

# Выполняем резервное копирование
rsync -a --delete --exclude='.*' -c "$SOURCE" "$DEST" 2>&1

# Проверяем статус выполнения
if [ $? -eq 0 ]; then
    logger -t "$LOG_TAG" "Резервное копирование успешно завершено"
    echo "[$(date)] SUCCESS: Резервное копирование выполнено" >> /var/log/backup.log
else
    logger -t "$LOG_TAG" "Ошибка при резервном копировании"
    echo "[$(date)] ERROR: Резервное копирование не выполнено" >> /var/log/backup.log
fi
