#! /bin/bash

source ./assets/set_color.sh


function extract_ips()
{
	local is_tor="$1"
	local input_file="$2"

	if [ ! -f "$input_file" ]; then
    echo "${input_file} does not exist..."
    return 1
  fi

  echo -e "\nServers ip addresses:" >> "$info_file"

  while read -r line; do
    server=$(echo "$line" | awk '{print $NF}')

	  echo "extracting ip addresses..."

    ip=$($is_tor host -t A "$server" | awk '/has address/ {print $NF}')

    echo "$server --> $ip" >> "$info_file"
  done < "$input_file"

  echo "Extraction of IP addresses done. $(set_color "green")✓$(set_color "*")"
}


