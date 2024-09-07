#! /bin/bash

source ./assets/set_color.sh

source ./pkg/inputs/inputs.sh
source ./pkg/settings/services.sh
source ./pkg/settings/create_dir.sh
source ./pkg/outputs/success_output.sh
source ./pkg/validators/ipv4_validator.sh


function http_brute_attack()
{
  services "HTTP brute attack"

  proxychains_input
  if [[ $proxychains == [Yy] ]]; then
    is_tor="proxychains4"
  else
    is_tor=""
  fi

  dns_input
  if ! ipv4_validator "$dns"; then
    return 1
  fi

  debug_mode
  if [[ $debug == [Yy] ]]; then
    debug_flag="-d"
  else
    debug_flag=""
  fi

  method_input

  dir_input
  create_dir "$dir_name/attacks/http_brute"

  $is_tor nmap -p80 --script=http-brute \
    --script-args=http-brute."$method" "$debug_flag" \
    -f --send-eth -D RND:3 \
    -oN "$HOME/$dir_name/attacks/http_brute/$dns.nmap" "$dns"

  success_output "$HOME/$dir_name/attacks/http_brute/$dns.nmap"
}
