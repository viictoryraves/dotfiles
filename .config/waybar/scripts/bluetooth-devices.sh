#!/usr/bin/env bash
# Emits JSON for a waybar custom module: always shows the bluetooth glyph,
# followed by one icon per connected device (headset, controller, mouse, ...).
# Device names only appear in the tooltip, not the bar text.

declare -A ICONS=(
  [audio-headset]="󰋋"
  [audio-headphones]="󰋋"
  [audio-card]=""
  [input-gaming]="󰊴"
  [input-mouse]="󰍽"
  [input-keyboard]="󰌌"
  [input-tablet]="󰓶"
  [phone]="󰄜"
  [computer]="󰟀"
)
DEFAULT_ICON=""
BT_ICON=""

mapfile -t lines < <(bluetoothctl devices Connected)

if [[ ${#lines[@]} -eq 0 ]]; then
  jq -nc --arg text "$BT_ICON" '{text: $text, tooltip: "No devices connected", class: "disconnected", alt: "disconnected"}'
  exit 0
fi

glyphs=()
tooltip_lines=()

for line in "${lines[@]}"; do
  mac=$(awk '{print $2}' <<< "$line")
  name=$(cut -d' ' -f3- <<< "$line")
  icon_name=$(bluetoothctl info "$mac" | awk -F'Icon: ' '/Icon:/ {print $2}')
  glyph="${ICONS[$icon_name]:-$DEFAULT_ICON}"
  glyphs+=("$glyph")
  tooltip_lines+=("$glyph $name ($mac)")
done

text="$BT_ICON"
for glyph in "${glyphs[@]}"; do
  text+=" $glyph"
done

tooltip=$(printf "%s\n" "${tooltip_lines[@]}")

jq -nc --arg text "$text" --arg tooltip "$tooltip" \
  '{text: $text, tooltip: $tooltip, class: "connected", alt: "connected"}'
