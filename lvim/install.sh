#! /bin/bash
config_file=~/.config/lvim/config.lua
if [ -e "$config_file" ]; then
	rm "$config_file"
fi
current_file=$(realpath "$0")
current_path=$(dirname "$current_file")
ln -s "$current_path"/config.lua "$config_file"
