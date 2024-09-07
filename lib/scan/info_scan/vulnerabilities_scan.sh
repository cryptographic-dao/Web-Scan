#! /bin/bash

source ./assets/set_color.sh

source ./pkg/inputs/inputs.sh
source ./pkg/settings/services.sh
source ./pkg/settings/create_dir.sh
source ./pkg/outputs/success_output.sh
source ./pkg/validators/ipv4_validator.sh
source ./pkg/validators/domain_validator.sh
source ./pkg/validators/cvss_score_validator.sh


function vulnerabilities_scan()
{
  echo "$(set_color "yellow")WARNING:$(set_color "*") We do not use proxychains in this script..."

  services "Vulnerabilities scan"

  domain_input
  if ! domain_validator "$domain"; then
    return 1
  fi

  cvss_score_input
  cvss_score_validator "$cvss_score"

  debug_mode
  if [[ $debug == [Yy] ]]; then
    debug_flag="-d"
  else
    debug_flag=""
  fi

  dir_input
  create_dir "$dir_name/vulnerabilities"

  nmap -sV -f --send-eth -D RND:3 \
    --script=vulners --script-args=vulners.mincvss="$cvss_score" "$debug_flag" \
    -oN "$HOME/$dir_name/vulnerabilities/$domain.nmap" "$domain"

  success_output "$HOME/$dir_name/vulnerabilities/$domain.nmap"
}
