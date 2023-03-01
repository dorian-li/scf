#! /bin/bash
proxyrc_file=~/.proxyrc
tmux_file=~/.tmux.conf
zshrc_file=~/.zshrc
if [ -e "$proxyrc_file" ]
then
  rm "$proxyrc_file"
fi
if [ -e "$tmux_file" ]
then
  rm "$tmux_file"
fi
if [ -e "$zshrc_file" ]
then
  rm "$zshrc_file"
fi
current_file=$(realpath "$0")
current_path=$(dirname "$current_file")
ln -s "$current_path"/.proxyrc "$proxyrc_file"
ln -s "$current_path"/.tmux.conf "$tmux_file"
ln -s "$current_path"/.zshrc "$zshrc_file"

