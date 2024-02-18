export EDITOR="nvim"

if [ "${PATH#*"$HOME/.local/bin"}" == "$PATH" ]; then
  PATH="$PATH:$HOME/.local/bin"
fi

DATA_HOME="${XDG_DATA_HOME}"
if [[ -z $DATA_HOME ]]; then
	DATA_HOME="$HOME/.local/share"
fi

STATE_HOME="${XDG_STATE_HOME}"
if [[ -z $STATE_HOME ]]; then
	STATE_HOME="$HOME/.local/state"
fi

# gnupg
export GNUPGHOME="$DATA_HOME"/gnupg

# go
export GOPATH="$DATA_HOME/go";
export GOROOT="$HOME/.local/bin/go";
export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g

# zsh
export ZDOTDIR="$HOME"/.config/zsh

# rust
export RUSTUP_HOME="$DATA_HOME"/rustup 
export CARGO_HOME="$DATA_HOME"/cargo
if [[ -e "/home/geofft/.local/share/cargo/env" ]]; then
  . "/home/geofft/.local/share/cargo/env"
fi

# android
export ANDROID_HOME="$DATA_HOME"/android

# luarocks
if command -v luarocks > /dev/null; then
  export PATH="$PATH:$(luarocks config variables.SCRIPTS_DIR)";
fi

case $- in
  *i* )
    if command -v zsh > /dev/null; then
        zsh --version > /dev/null && exec zsh
        echo "Couldn't run 'zsh'" > /dev/stderr
    fi
    ;;
esac
