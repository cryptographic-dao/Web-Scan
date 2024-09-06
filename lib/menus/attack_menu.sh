#! /bin/bash

source ./assets/ascii.sh
source ./assets/set_color.sh

function attack_menu()
{
	clear
        display_ascii_art
        echo -e "\n$(set_color "purple")----------------------------------------------------------------------------------------------$(set_color "*")"
	echo -e "\nAttack menu: "
	echo "$(set_color "purple")[1]$(set_color "*") - DDOS attack"
	echo "$(set_color "purple")[2]$(set_color "*") - HTTP brute"
	echo "$(set_color "purple")[3]$(set_color "*") - SSH brute"
	echo "$(set_color "purple")[4]$(set_color "*") - Wordpress attack"
	echo "$(set_color "purple")[0]$(set_color "*") <- Menu"
}
