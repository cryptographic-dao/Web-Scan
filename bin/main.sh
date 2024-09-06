#! /bin/bash

source ./assets/ascii.sh
source ./assets/set_color.sh

source ./lib/dns/get_dns.sh
source ./lib/scan/info_scan/info_scan.sh
source ./lib/scan/attack_scan/attack_scan.sh
source ./lib/pdf/pdf_combiner.sh

source ./pkg/menus/menu.sh
source ./pkg/inputs/inputs.sh
source ./pkg/errors/errors.sh


function main()
{
	while true; do
		menu
		menu_input

		case $choice in
			1)
				get_dns
				continue_using
				;;
			2)
				info_scan
				;;
			3)
				attack_scan
				;;
			4)
				echo "PDF combiner is under maintenance..."
				pdf_combiner
				continue_using
				;;
			0)
				echo "$(set_color "purple")Goodbye!$(set_color "*")"
				return 1
				;;
			*)
				invalid_menu_input
				continue_using
				;;
		esac
	done
}

main
