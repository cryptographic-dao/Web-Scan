#!/bin/bash

source ./pkg/validators/choice_validator.sh
source ./pkg/validators/ports_validator.sh
source ./pkg/validators/paths_validator.sh


function menu_input()
{
    read -rp "Enter your choice: " choice
}

function continue_using()
{
    echo "$(set_color "green")Press any button to continue...$(set_color "*")"
    read -r
}

function proxychains_input()
{
    read -rp "Do you want to use Tor proxychains [Y/n]? " proxychains
    choice_validator "$proxychains"
}

function domain_input()
{
    read -rp "Provide url or domain name (ex.: example.com): " domain
    export domain
}

function dns_input()
{
    read -rp "Provide DNS of the website (ex.: 45.33.49.119): " dns
    export dns
}

function method_input()
{
    read -rp "Provide HTTP Method (ex.: GET): " method
    export method
}

function ports_input()
{
    read -rp "Provide ports of the website that you want to scan or skip it (ex.: 22,80,443): " ports
    if [[ -z "$ports" ]]; then
        ports="-"
    fi
    ports_validator "$ports"
    export ports
}

function scripts_input()
{
    read -rp "Provide scripts you want to execute (ex.: http-waf-detect): " scripts
    read -rp "Provide scripts' args if necessary (ex.: ssh-run.cmd=ls -l /, ssh-run.username=root): " args
    export scripts
    export args
}

function debug_mode()
{
    read -rp "Do you want to enable debugging mode [Y/n]: " debug
    choice_validator "$debug"
    export debug
}

function cvss_score_input()
{
    read -rp "Enter CVSS score or skip (ex.: 7.0): " cvss_score
    export cvss_score
}

function dir_input()
{
    read -rp "Provide a directory name: " dir_name
    export dir_name
}

function file_input()
{
    read -rp "Provide a file name: " file_name
    export file_name
}

function paths_input()
{
    read -rp "Provide paths to the .nmap files, which are in scan folder (ex.: path/to/file path/to/file): " paths
    paths_validator "$paths"
    export paths
}
