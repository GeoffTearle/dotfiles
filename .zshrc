#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

ZSH_AUTOSUGGEST_USE_ASYNC="true"

source ~/dotfiles/zsh/antigen.zsh

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  docker
  command-not-found
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  belak/zsh-utils editor
  belak/zsh-utils utility
  belak/zsh-utils history
  belak/zsh-utils completion
#  chrissicool/zsh-bash
EOBUNDLES
antigen apply

source ~/dotfiles/zsh/platform-specific.zsh

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PAGER="bat --style='changes,rule'"

eval "$(starship init zsh)"

export GOPATH="$HOME/go"; export GOROOT="$HOME/.go"; export PATH="$GOPATH/bin:$PATH"; # g-install: do NOT edit, see https://github.com/stefanmaric/g

alias ssh="kitty +kitten ssh"

# exa
alias ls="exa --icons"
alias ll="exa -l -g --icons"
alias la="exa -l -a -g --icons"
