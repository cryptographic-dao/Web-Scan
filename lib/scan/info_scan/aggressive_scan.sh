#! /bin/bash

source ./assets/set_color.sh

source ./lib/scan/helpers/create_dir.sh
source ./lib/scan/helpers/inputs.sh
source ./lib/settings/services.sh
source ./lib/settings/tor.sh
source ./lib/util/success_output.sh

source ./validators/ipv4_validator.sh


function aggressive_scan()
{
	services "Aggressive"

  proxychains_input
  if [[ $proxychains == [Yy] ]]; then
	tor_service
    is_tor="proxychains4"
  else
    is_tor=""
  fi

	dns_input
  ipv4_validator "$dns"
  if [ $? -ne 0 ]; then
    return 1
  fi

	ports_input

	debug_mode
	if [[ $debug == [Yy] ]]; then
		debug_flag="-d"
	else
		debug_flag=""
	fi

	scripts_input

	dir_input
	create_dir "$dir_name/aggressive"


	$is_tor nmap -A -p "$ports" \
	 --script="$scripts" --script-args="$args" $debug_flag \
	 -oN "$HOME/$dir_name/aggressive/$dns.nmap" "$dns"

	success_output "$HOME/$dir_name/aggressive/$dns.nmap"
}
