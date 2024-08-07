install_miniforge() {
    if [ ! -f "$HOME/miniforge3/bin/conda" ]; then
        echo "Installing miniforge..."
        wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh -O $HOME/miniforge.sh &&
        bash $HOME/miniforge.sh -b -p $HOME/miniforge3 &&
        rm $HOME/miniforge.sh &&
        echo "Miniforge installed successfully." ||
        { echo "Failed to install Miniforge."; return 1; }
    fi
}
install_miniforge && {
    AUTOSWITCH_DEFAULT_CONDAENV="base"
    __conda_setup="$('$HOME/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
	    . "$HOME/miniforge3/etc/profile.d/conda.sh"
        else
	    export PATH="$HOME/miniforge3/bin:$PATH"
        fi
    fi
    unset __conda_setup

    if [ -f "$HOME/miniforge3/etc/profile.d/mamba.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/mamba.sh"
    fi
}

antidote_dir="${ZDOTDIR:-$HOME}/.antidote"
install_antidote() {
    [[ -d "$antidote_dir" ]] && return 0
    echo "Installing antidote..."
    git clone --depth=1 https://github.com/mattmc3/antidote.git "$antidote_dir" && echo "antidote installed successfully." || {
        echo "Failed to install antidote."
        return 1
    }
}
install_antidote && {
    source "$antidote_dir/antidote.zsh"
    antidote load
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
}

install_rust_cargo() {
    command -v cargo &> /dev/null || { 
        echo "Installing Rust and Cargo..."
        curl -sSf https://sh.rustup.rs | sh -s -- -y
    }
}
install_rust_cargo && source "$HOME/.cargo/env"

install_fnm() {
    command -v fnm &> /dev/null || {
	echo "Installing fnm ..." 
        cargo install fnm
    }
}
install_fnm && eval "$(fnm env --use-on-cd)"

export PATH=$HOME/.local/bin:$PATH
export EDITOR=lvim

HISTSIZE=1000
SAVEHIST=1000
