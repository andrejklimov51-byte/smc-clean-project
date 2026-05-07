#!/bin/bash
FILE="D:/SMC_PROJECT_CLEAN/01_PINE/core/smc_clean_l0_core.pine"

# Попытка 1 — dpaste
URL=$(curl -s -X POST "https://dpaste.com/api/v2/" \
  --data-urlencode "content@$FILE" \
  -d "syntax=text" -d "expiry_days=7" 2>/dev/null)
if [[ $URL == https* ]]; then echo "КОД: $URL"; exit 0; fi

# Попытка 2 — paste.rs
URL=$(curl -s --data-binary @"$FILE" "https://paste.rs" 2>/dev/null)
if [[ $URL == https* ]]; then echo "КОД: $URL"; exit 0; fi

# Попытка 3 — ix.io
URL=$(curl -s -F "f:1=@$FILE" "http://ix.io" 2>/dev/null)
if [[ $URL == http* ]]; then echo "КОД: $URL"; exit 0; fi

echo "КОД: НЕДОСТУПЕН — все сервисы упали"
