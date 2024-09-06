#! /bin/bash

function create_dir()
{
	local dir_name="$1"

	mkdir -p "$HOME/$dir_name"
}
