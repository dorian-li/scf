user_dir=(eval echo ~$USER)
# !! Contents within this block are managed by 'conda init' !!
#>>> conda initialize >>>
__conda_setup="$('/home/dorian/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dorian/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dorian/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dorian/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

. "$HOME/.cargo/env"
eval "$(fnm env --use-on-cd)"

export PATH=/home/dorian/.local/bin:$PATH
export EDITOR=lvim

ANTIGEN="$HOME/.local/bin/antigen.zsh"

# Install antigen.zsh if not exist
# Thanks skywind3000
if [ ! -f "$ANTIGEN" ]; then
  echo "Installing antigen ..."
  [ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
  [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
  # [ ! -f "$HOME/.z" ] && touch "$HOME/.z"
  URL="http://git.io/antigen"
  TMPFILE="/tmp/antigen.zsh"
  if [ -x "$(which curl)" ]; then
    curl -L "$URL" -o "$TMPFILE" 
  elif [ -x "$(which wget)" ]; then
    wget "$URL" -O "$TMPFILE" 
  else
    echo "ERROR: please install curl or wget before installation !!"
    exit
  fi
  if [ ! $? -eq 0 ]; then
    echo ""
    echo "ERROR: downloading antigen.zsh ($URL) failed !!"
    exit
  fi;
  echo "move $TMPFILE to $ANTIGEN"
  mv "$TMPFILE" "$ANTIGEN"
  # Change prezto repo to get fskwp prompt theme
  sed -i 's/sorin-ionescu/dorian-li/g' "$ANTIGEN"
fi

source "$ANTIGEN"
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:prompt' theme 'fskwp'
zstyle ':prezto:module:prompt' pwd-length 'short'
zstyle ':prezto:load' pmodule \
  'environment' \
  'history' \
  'utility' \
  'git' \
  'completion' \
  'history-substring-search' \
  'autosuggestions' \
  'prompt' \

antigen use prezto
antigen bundle conda-incubator/conda-zsh-completion
antigen bundle dorian-li/fnm
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen apply

# auto set proxy if wsl
if grep -qi wsl /proc/version
then
  source "$HOME/.proxyrc"
fi

[[ -s "/home/dorian/.gvm/scripts/gvm" ]] && source "/home/dorian/.gvm/scripts/gvm"
