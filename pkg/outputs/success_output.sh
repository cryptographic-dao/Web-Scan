#! /bin/bash

source ./assets/set_color.sh


function success_output()
{
	local file_name="$1"

	echo -e "\n$(set_color "green")Success ✓$(set_color "*")\n"
	echo "$(set_color "purple")Output is here:$(set_color "*") $file_name"
}
