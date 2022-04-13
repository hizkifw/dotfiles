#!/usr/bin/env bash
# requires jq

display_config=($(
  i3-msg -t get_outputs \
    | jq -r '
      map(select(.current_workspace)) | .[]
      | "\(.name):\(.current_workspace)"
    '
))

# Swap workspaces
for row in "${display_config[@]}"
do
  IFS=':'
  read -ra config <<< "${row}"
  if [ "${config[0]}" != "null" ] && [ "${config[1]}" != "null" ]; then
    echo "moving ${config[1]} right..."
    i3-msg -- workspace --no-auto-back-and-forth "${config[1]}"
    i3-msg -- move workspace to output right
  fi
done
