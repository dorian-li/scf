#! /bin/bash
config_file=~/.config/lvim/config.lua
if [ -e "$config_file" ]
then
  rm "$config_file"
fi
current_file=$(realpath "$0")
current_path=$(dirname "$current_file")
ln -s "$current_path"/config.lua "$config_file"

# install win32yank
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/
