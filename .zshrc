#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export DO_NOT_TRACK=1

ZSH_AUTOSUGGEST_USE_ASYNC="true"

source ~/dotfiles/zsh/antigen.zsh

autoload -Uz +X compinit && compinit

## case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  docker
  command-not-found
  belak/zsh-utils editor
  belak/zsh-utils utility
  belak/zsh-utils history
  belak/zsh-utils completion
  wfxr/forgit
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
#  chrissicool/zsh-bash
EOBUNDLES
antigen apply


source ~/.local.zsh
source ~/dotfiles/zsh/platform-specific.zsh

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PAGER="bat --style='changes,rule'"

eval "$(starship init zsh)"


export PATH="$PATH:$HOME/.antigen/bundles/wfxr/forgit/bin" # cant seem to get the antigen vars to work

# exa
alias ls="exa --icons"
alias ll="exa --long --group --icons --header --git"
alias la="exa --long --all --group --icons --header --git"

case $(uname) in
  Linux)
  ;;
  Darwin)
	## Dumping ground for work required programs that love to dump stuff in my rc's
	export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g
	source /Users/geoffreyt/.docker/init-zsh.sh || true # Added by Docker Desktop
  ;;
esac
