#!/bin/bash
# Push active core file to dpaste.com
# Usage: bash push_to_paste.sh

CORE_FILE="D:/SMC_PROJECT_CLEAN/01_PINE/core/smc_clean_l0_core.pine"

if [ ! -f "$CORE_FILE" ]; then
    echo "ERROR: Core file not found: $CORE_FILE"
    exit 1
fi

echo "Uploading $CORE_FILE to dpaste.com..."

URL=$(curl -s -F "content=<$CORE_FILE" -F "syntax=text" -F "expiry_days=1" https://dpaste.com/api/v2/)

if [ -z "$URL" ]; then
    echo "ERROR: Upload failed"
    exit 1
fi

echo "SUCCESS: $URL"
echo "$URL" | clip
echo "(URL copied to clipboard)"
