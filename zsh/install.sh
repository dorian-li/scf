#! /bin/bash
proxyrc_file=~/.proxyrc
tmux_file=~/.tmux.conf
zshrc_file=~/.zshrc
if [ -L "$proxyrc_file" ]
then
  rm "$proxyrc_file"
fi
if [ -L "$tmux_file" ]
then
  rm "$tmux_file"
fi
if [ -L "$zshrc_file" ]
then
  rm "$zshrc_file"
fi
current_file=$(realpath "$0")
current_path=$(dirname "$current_file")
ln -s "$current_path"/.proxyrc "$proxyrc_file"
ln -s "$current_path"/.tmux.conf "$tmux_file"
ln -s "$current_path"/.zshrc "$zshrc_file"

