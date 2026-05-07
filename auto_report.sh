#!/bin/bash
# auto_report.sh — загрузка кода на dpaste и скриншота на imgur

CORE_FILE="D:/SMC_PROJECT_CLEAN/01_PINE/core/smc_clean_l0_core.pine"
SCREENSHOT="D:/SMC_PROJECT_CLEAN/latest_screenshot.png"

# Загрузка кода на dpaste
echo "Uploading code to dpaste..."
DPASTE_URL=$(curl -s -X POST https://dpaste.com/api/ \
  -F "content=@$CORE_FILE" \
  -F "syntax=python" \
  -F "expiry_days=7" | grep -oP 'https://dpaste.com/\w+')

if [ -z "$DPASTE_URL" ]; then
  echo "ERROR: dpaste upload failed"
  exit 1
fi

echo "Code URL: $DPASTE_URL"

# Загрузка скриншота на imgur
echo "Uploading screenshot to imgur..."
IMGUR_RESPONSE=$(curl -s -X POST https://api.imgur.com/3/image \
  -H "Authorization: Client-ID 546c25a59c58ad7" \
  -F "image=@$SCREENSHOT")

IMGUR_URL=$(echo "$IMGUR_RESPONSE" | grep -oP '"link":"https://i.imgur.com/\w+\.png"' | sed 's/"link":"//;s/"//')

if [ -z "$IMGUR_URL" ]; then
  echo "ERROR: imgur upload failed"
  echo "Response: $IMGUR_RESPONSE"
  exit 1
fi

echo "Screenshot URL: $IMGUR_URL"

# Вывод обоих URL
echo ""
echo "=== REPORT ==="
echo "Code: $DPASTE_URL"
echo "Screenshot: $IMGUR_URL"
