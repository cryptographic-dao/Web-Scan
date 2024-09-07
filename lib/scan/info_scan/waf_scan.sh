#! /bin/bash

source ./assets/set_color.sh

source ./pkg/settings/tor.sh
source ./pkg/inputs/inputs.sh
source ./pkg/settings/services.sh
source ./pkg/settings/create_dir.sh
source ./pkg/outputs/success_output.sh
source ./pkg/validators/ipv4_validator.sh


function waf_scan()
{
  services "WAF detection"

  proxychains_input
  if [[ $proxychains == [Yy] ]]; then
    tor_service
    is_tor="proxychains4"
  else
    is_tor=""
  fi

  dns_input

  if ! ipv4_validator "$dns"; then
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
  create_dir "$dir_name/waf"

  $is_tor nmap -p"$ports" \
    -f --send-eth -D RND:3 \
    --script=http-waf-detect,http-waf-fingerprint \
    --script-args=http-waf-detect.aggro,http-waf-fingerprint.intensive=1 "$debug_flag" \
    -oN "$HOME/$dir_name/waf/$dns.nmap" "$dns"

  printf "\n\n\n\n" >> "$HOME/$dir_name/waf/$dns.nmap"

  success_output "$HOME/$dir_name/waf/$dns.nmap"
}
