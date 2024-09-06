#!/bin/bash

source ./assets/set_color.sh

source ./lib/dns/extract_ips.sh

source ./pkg/settings/tor.sh
source ./pkg/inputs/inputs.sh
source ./pkg/settings/services.sh
source ./pkg/outputs/success_output.sh
source ./pkg/validators/domain_validator.sh


function get_dns() {
    proxychains_input
    if [[ $proxychains == [Yy] ]]; then
        tor_service
        is_tor="proxychains4"
    else
        is_tor=""
    fi

    domain_input
    base_name=$(domain_validator "$domain")

    # Directly checking the success of `domain_validator`
    # shellcheck disable=SC2181
    if [[ $? -ne 0 ]]; then
        return 1
    fi

    dir_input
    servers_names_file="$HOME/$dir_name/servers.nmap"
    info_file="$HOME/$dir_name/addresses.nmap"

    mkdir -p "$HOME/$dir_name"
    touch -c "$info_file"

    echo "Victim: $base_name" > "$info_file"

    # Check nslookup command directly
    if ! $is_tor nslookup "$base_name" | grep "Address: " >> "$info_file"; then
        echo "$(set_color "red")Error:$(set_color "*") Failed to execute nslookup. Aborting."
        return 1
    fi

    # Check host command directly
    if ! $is_tor host -t ns "$base_name" >> "$servers_names_file"; then
        echo "$(set_color "red")Error:$(set_color "*") Failed to execute host. Aborting."
        return 1
    fi

    if [[ ! -s "$servers_names_file" ]]; then
        echo "$(set_color "red")Error:$(set_color "*") No IP addresses found for the website. Aborting."
        return 1
    fi

    # Check extract_ips command directly
    if ! extract_ips "$is_tor" "$servers_names_file" "$info_file"; then
        echo "$(set_color "red")Error:$(set_color "*") Failed to extract IP addresses. Aborting."
        return 1
    fi

    printf "\n\n\n\n" >> "$info_file"

    # Check removal of temporary file directly
    if ! rm "$servers_names_file"; then
        echo "$(set_color "yellow")Warning:$(set_color "*") Failed to remove temporary file '$servers_names_file'."
    fi

    success_output "$info_file"
}
