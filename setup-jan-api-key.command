#!/bin/bash

# This is a one-time setup. This script stores your Jan API key in macOS Keychain 
# so scripts never hardcode it.
# Run this ONCE in Terminal, then delete it.


read -rsp "Paste your Jan/Custom API key (input hidden): " API_KEY
echo

if [ -z "$API_KEY" ]; then
    echo "No key entered. Exiting."
    exit 1
fi

# Removes any existing entry first to avoid duplicates
security delete-generic-password \
    -a "jan-api" \
    -s "jan-api-key" \
    2>/dev/null

# Stores the key
security add-generic-password \
    -a "jan-api" \
    -s "jan-api-key" \
    -w "$API_KEY"

echo "API key saved to Keychain under 'jan-api-key'."
echo "   You can verify it anytime with:"
echo "   security find-generic-password -a jan-api -s jan-api-key -w"
