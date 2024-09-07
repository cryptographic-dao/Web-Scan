#! /bin/bash

source ./assets/set_color.sh


function paths_validator()
{
	local paths="$1"

  IFS=' ' read -r -a path_array <<< "$paths"
    for path in "${path_array[@]}"; do
      if [[ ! "$path" =~ ^(.+)\/([^\/]+)$ ]]; then
        echo "$(set_color "red")Invalid path: $path$(set_color "*")"
        exit 1
      fi
    done
}
