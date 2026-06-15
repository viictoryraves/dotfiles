#!/bin/bash
nvidia_icon=$(printf '\U0001D5E1') # 𝗡 sans-serif bold N
bolt_icon=$(printf '')            # nf-fa-bolt
mem_icon=$(printf '')             # same as waybar memory module

nvidia-smi --query-gpu=power.draw,power.limit,memory.used,memory.total \
  --format=csv,noheader,nounits 2>/dev/null |
  awk -F', ' -v n="$nvidia_icon" -v b="$bolt_icon" -v m="$mem_icon" '{
    pw = int($1 + 0.5)
    pl = int($2 + 0.5)
    mp = int($3 * 100 / $4 + 0.5)
    printf "%s %d/%d %s %d\n", b, pw, pl, m, mp
  }'
