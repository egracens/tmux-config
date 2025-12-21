#!/bin/bash
# Shows public IP (fetches and caches both IP and country)

CACHE_FILE="/tmp/tmux_ip_cache"
CACHE_TTL=60  # 1 minute

# Check if cache is fresh
if [ -f "$CACHE_FILE" ]; then
    cache_age=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE")))
    if [ "$cache_age" -lt "$CACHE_TTL" ]; then
        head -1 "$CACHE_FILE"
        exit 0
    fi
fi

# Fetch fresh data
response=$(curl -s --max-time 2 ipinfo.io)

if [ -n "$response" ]; then
    ip=$(echo "$response" | grep -o '"ip": "[^"]*' | cut -d'"' -f4)
    country=$(echo "$response" | grep -o '"country": "[^"]*' | cut -d'"' -f4)
    echo "$ip" > "$CACHE_FILE"
    echo "$country" >> "$CACHE_FILE"
    echo "$ip"
else
    [ -f "$CACHE_FILE" ] && head -1 "$CACHE_FILE" || echo "N/A"
fi
