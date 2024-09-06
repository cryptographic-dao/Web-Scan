#! /bin/bash

source ./assets/ascii.sh
source ./assets/set_color.sh


function menu()
{
	clear
	display_ascii_art
	echo -e "\n$(set_color "purple")-----------------------------------------------------------------------------\
-----------------$(set_color "*")"
	echo -e "\nMenu:"
	echo "$(set_color "purple")[1]$(set_color "*") - Get dns address"
	echo "$(set_color "purple")[2]$(set_color "*") - Scan the victim"
	echo "$(set_color "purple")[3]$(set_color "*") - Attack the victim"
	echo "$(set_color "purple")[4]$(set_color "*") - PDF combiner"
	echo "$(set_color "purple")[0]$(set_color "*") - Exit"
}
