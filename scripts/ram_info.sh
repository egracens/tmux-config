#!/bin/bash
# Shows RAM usage like htop: "1.07G/15.6G"

free -b | awk '/^Mem:/ {
    used = $3 / 1024 / 1024 / 1024
    total = $2 / 1024 / 1024 / 1024
    printf "%.2fGB/%.1fGB", used, total
}'
