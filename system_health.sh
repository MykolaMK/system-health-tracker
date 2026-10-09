#!/bin/bash

DATA=$(date +%Y-%m-%d)
FOLDER_ZAPASOWY="/tmp/backups"
FOLDER_RAPORTOW="./reports"
LOG_FOLDER="/var/log/auth.log"

#1 Funkcja

uzycieDysku=$(df -h)
uzycieRAM=$(free -m)
nazwaUzytkownika=$(whoami)
ipUzytkownika=$(hostname -I | awk '{print $1}')

mkdir -p "$FOLDER_ZAPASOWY"
mkdir -p "$FOLDER_RAPORTOW"

REPORT=$FOLDER_RAPORTOW/report_$DATA.log

echo "=== UŻYCIE DYSKU ===" > "$REPORT"
echo "$uzycieDysku" >> "$REPORT"

echo "=== UŻYCIE RAM ===" >> "$REPORT"
echo "$uzycieRAM" >> "$REPORT"

echo "=== NAZWA UŻYTKOWNIKA ===" >> "$REPORT"
echo "$nazwaUzytkownika" >> "$REPORT"

echo "=== ADRES IP UŻYTKOWNIKA ===" >> "$REPORT"
echo "$ipUzytkownika" >> "$REPORT"

# 2. ANALIZA LOGÓW
echo "----- NIEUDANE PRÓBY LOGOWANIA -----"

if [ -f "$LOG_FOLDER" ]; then
    grep "Failed password" "$LOG_FOLDER" | awk '{
        for(i=1; i<=NF; i++) {
            if($i == "from") print $(i+1)
        }
    }' | sort | uniq -c | sort -nr
else
    echo "Plik $LOG_FOLDER nie istnieje na tej maszynie."
fi

# 3. ARCHIWIZACJA (BACKUP)

read -p "Wpisz y/n jeżeli chcesz archiwizowac (y - yes, n - not): " decyzja

case $decyzja in
y)
echo "------------------------------------"
read -p "Podaj ścieżkę do folderu do archiwizacji: " nazwaFolderu

if [ -d "$nazwaFolderu" ]; then
    tar -czvf "$FOLDER_ZAPASOWY/backup_$DATA.tar.gz" "$nazwaFolderu"
    echo "Kopia zapasowa zapisana w $FOLDER_ZAPASOWY/backup_$DATA.tar.gz"
else
    echo "Katalog $nazwaFolderu nie istnieje!"
fi ;;

n) echo "Miłego dnia:)" ;;

*) echo "Nie znam takiego polecenia:(" ;;
esac