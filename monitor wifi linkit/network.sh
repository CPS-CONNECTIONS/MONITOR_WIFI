#!/bin/sh

SSID="INJETMK"
IFACE="apcli0"
STA_SECTION="sta"  # Nome da seção do UCI usada no wireless
echo "🔎 Procurando redes com SSID \"$SSID\"..."

# Faz scan e seleciona o BSSID com maior sinal
BSSID=$(iwinfo "$IFACE" scan | awk -v ssid="$SSID" '
  /Cell/ {mac=$NF; signal=""}
  /ESSID/ && $0 ~ ssid {ok=1}
  /Signal/ && ok { signal=$2 }
  /^$/ { if (ok) print signal, mac; ok=0 }
' | sort -nr | head -n1 | awk '{print $2}')

if [ -z "$BSSID" ]; then
  echo "❌ Nenhum ponto de acesso encontrado com SSID \"$SSID\"."
  exit 1
fi

echo "✅ Melhor BSSID encontrado: $BSSID"

# Lê o BSSID atual configurado no UCI (se existir)
BSSID_ATUAL=$(uci get wireless.$STA_SECTION.bssid 2>/dev/null)

if [ "$BSSID" != "$BSSID_ATUAL" ]; then
  echo "⚙️ Atualizando BSSID em /etc/config/wireless..."
  uci set wireless.$STA_SECTION.bssid="$BSSID"
  uci commit wireless

  echo "🔄 Recarregando Wi-Fi..."
  wifi reload

  echo "✅ Conectado a $SSID via $BSSID (BSSID atualizado)"
else
  echo "ℹ️ Já conectado ao melhor repetidor ($BSSID). Nenhuma ação necessária."
fi
