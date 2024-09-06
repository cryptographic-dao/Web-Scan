#! /bin/bash

source ./assets/set_color.sh


function choice_validator()
{
	local choice="$1"

	if [[ $choice =~ ^[YyNn]$ ]]; then
    return 0
  else
    echo "$(set_color "red")Unknown character, please, try again...$(set_color "*")" >&2
		exit 1
  fi
}
