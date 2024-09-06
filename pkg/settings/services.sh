#! /bin/bash

source ./lib/settings/network_manager.sh

function services()
{
	local option="$1"

	echo "Preparing configuration before $option..."

	OS=$(uname)

  if [[ "$OS" == "Linux" ]]; then
      check_network_linux
  elif [[ "$OS" == "Darwin" ]]; then
      check_network_macos
  else
      echo "Unsupported OS: $OS"
      return 1
  fi
}
