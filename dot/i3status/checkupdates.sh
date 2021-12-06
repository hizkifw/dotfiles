#!/bin/bash

fpath="$HOME/.cache/checkupdates"
nupdates=$(/usr/bin/checkupdates | wc -l)

(( $nupdates > 0 )) && echo $nupdates > "$fpath" || rm "$fpath"
