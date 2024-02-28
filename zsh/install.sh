#! /bin/bash
tmux_file=~/.tmux.conf
zshrc_file=~/.zshrc
zsh_plugins_txt=~/.zsh_plugins.txt
if [ -e "$tmux_file" ]; then
	rm "$tmux_file"
fi
if [ -e "$zshrc_file" ]; then
	rm "$zshrc_file"
fi
if [ -e "$zsh_plugins_txt" ]; then
	rm "$zsh_plugins_txt"
fi
current_file=$(realpath "$0")
current_path=$(dirname "$current_file")
ln -s "$current_path"/.tmux.conf "$tmux_file"
ln -s "$current_path"/.zshrc "$zshrc_file"
ln -s "$current_path"/.zsh_plugins.txt "$zsh_plugins_txt"
