#! /bin/bash

source ./assets/set_color.sh

source ./lib/scan/attack_scan/dos_attack.sh
source ./lib/scan/attack_scan/http_brute.sh
source ./lib/scan/attack_scan/ssh_brute.sh
source ./lib/scan/attack_scan/wordpress_attack.sh

source ./pkg/menus/attack_menu.sh
source ./pkg/inputs/inputs.sh
source ./pkg/errors/errors.sh


function attack_scan()
{
	while true; do
		attack_menu
		menu_input

		case $choice in
			1)
				dos_attack
				continue_using
				;;
			2)
				http_brute_attack
				continue_using
				;;
			3)
				ssh_brute_attack
				continue_using
				;;
			4)
				wordpress_attack
				continue_using
				;;
			0)
				break
				;;
			*)
				invalid_menu_input
				continue_using
				;;
		esac
	done
}
