#!/bin/bash

# Função para registrar mensagens com data e hora
logger() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Nome da rede
SSID="INJETMK"

# Obtém a lista de BSSIDs disponíveis para o SSID "INJETMK"
BEST_BSSID=$(nmcli -t -f SIGNAL,SSID,BSSID dev wifi | grep "INJETMK" | sort -nr | head -n 1 | awk -F ':' '{OFS=":"; print $3,$4,$5,$6,$7,$8}' | tr -d '\\')

if [[ -z "$BEST_BSSID" ]]; then
    logger "Nenhum repetidor encontrado para $SSID. Mantendo conexão atual."
    exit 1
fi

# Obtém o BSSID atual conectado
CURRENT_BSSID=$(nmcli -t -f ACTIVE,SSID,BSSID dev wifi | grep '^yes' | awk -F ':' '{OFS=":"; print $3,$4,$5,$6,$7,$8}' | tr -d '\\')

# Se o melhor BSSID for diferente do atual, troca para ele
if [[ "$BEST_BSSID" != "$CURRENT_BSSID" ]]; then
    logger "Mudando para o repetidor com melhor sinal: $BEST_BSSID"
    nmcli connection down $SSID
    sleep 2
    nmcli connection modify $SSID wifi.bssid $BEST_BSSID
    nmcli connection up $SSID
else
    logger "Ja conectado ao melhor repetidor ($CURRENT_BSSID)"
fi