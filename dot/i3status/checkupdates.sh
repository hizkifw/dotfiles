#!/bin/bash

fpath="$HOME/.cache/checkupdates"
nupdates=$(/usr/bin/checkupdates | wc -l)

if (( $nupdates > 0 )); then
  echo -n "$nupdates update" > "$fpath"
  (( $nupdates > 1 )) && echo 's' >> "$fpath"
else
  rm "$fpath"
fi
