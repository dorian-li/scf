install_miniconda() {
    if [ ! -f "$HOME/miniconda3/bin/conda" ]; then
        echo "Installing miniconda..."
        wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $HOME/miniconda.sh &&
        bash $HOME/miniconda.sh -b -p $HOME/miniconda3 &&
        rm $HOME/miniconda.sh &&
	echo "Miniconda installed successfully." ||
        { echo "Failed to install Miniconda."; return 1; }
    fi
}
install_miniconda && {
    AUTOSWITCH_DEFAULT_CONDAENV="base"
    __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
	    . "$HOME/miniconda3/etc/profile.d/conda.sh"
        else
	    export PATH="$HOME/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
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
