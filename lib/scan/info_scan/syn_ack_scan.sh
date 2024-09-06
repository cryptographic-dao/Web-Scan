#! /bin/bash

source ./assets/set_color.sh

source ./lib/scan/helpers/inputs.sh
source ./lib/scan/helpers/create_dir.sh
source ./lib/settings/tor.sh
source ./lib/settings/services.sh
source ./lib/util/success_output.sh

source ./validators/ipv4_validator.sh


function syn_ack_scan()
{
	services "TCP SYN/ACK"

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
	scripts_input

	debug_mode
	if [[ $debug == [Yy] ]]; then
		debug_flag="-d"
	else
		debug_flag=""
	fi

	dir_input
	create_dir "$dir_name/syn_ack"


	$is_tor nmap -sA -p"$ports" -sV \
	 -f --send-eth -D RND:3 \
	 --script="$scripts" --script-args="$args" $debug_flag \
	 -oN "$HOME/$dir_name/syn_ack/$dns.nmap" "$dns"

	success_output "$HOME/$dir_name/syn_ack/$dns.nmap"
}
