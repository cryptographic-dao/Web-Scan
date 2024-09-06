#!/bin/bash

source ./assets/set_color.sh

# Function to check and start Tor service
function tor_service()
{
  echo "Checking Tor status..."
  local tor_output

  # Detect OS type
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    tor_status=$(service tor status)
    tor_start=$(service tor start)
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    tor_status=$(brew services list | grep tor)
    tor_start="brew services start tor"
  else
    echo "$(set_color "red")Error:$(set_color "*") Unsupported OS."
    return 1
  fi

  # Check Tor status
  if echo "$tor_status" | grep -q "started\|Active: active"; then
    echo "Service Tor is running. $(set_color "green")✓$(set_color "*")"
  else
    echo "Tor is down."
    echo "Starting Tor..."

    if tor_output=$($tor_start 2>&1); then
      echo -e "\n$(set_color "green")Success ✓$(set_color "*")\n"
    else
      echo "$(set_color "red")Error:$(set_color "*") error starting Tor."
      echo "$tor_output"
      return 1
    fi
  fi
}
