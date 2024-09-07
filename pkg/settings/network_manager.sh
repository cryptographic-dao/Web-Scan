#!/bin/bash

source ./assets/set_color.sh


# Function to check and manage NetworkManager on Linux
function check_network_linux() {
    network_status=$(service NetworkManager status)
    network_start=$(service NetworkManager start)

    echo "checking NetworkManager status on Linux..."

    if echo "$network_status" | grep -q "Active: active"; then
        echo "service NetworkManager is running. $(set_color "green")✓$(set_color "*")"
    else
        echo "NetworkManager is down."
        echo "starting NetworkManager..."

        if network_output=$($network_start 2>&1); then
            echo "$(set_color "green")Success ✓$(set_color "*")"
        else
            echo "$(set_color "red")Error:$(set_color "*") error starting NetworkManager."
            echo "$network_output"
            return 1
        fi
    fi
}

# Function to check and manage the network on macOS
function check_network_macos() {
    interface="Wi-Fi"  # You can change this to "Ethernet" or any other interface

    echo "checking network status on macOS..."

    # Check if Wi-Fi is active
    if networksetup -getnetworkserviceenabled "$interface" | grep -q "Enabled"; then
        echo "Network interface $interface is active. $(set_color "green")✓$(set_color "*")"
    else
        echo "$interface is down."
        echo "starting $interface..."

        # Enable the network interface (sudo might be required)
        if sudo networksetup -setnetworkserviceenabled "$interface" on; then
            echo "$(set_color "green")Success ✓$(set_color "*")"
        else
            echo "$(set_color "red")Error:$(set_color "*") error starting $interface."
            return 1
        fi
    fi
}
