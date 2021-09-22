#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

ZSH_AUTOSUGGEST_USE_ASYNC="true"

source ~/dotfiles/zsh/antigen.zsh

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
  belak/zsh-utils editor
  belak/zsh-utils utility
  belak/zsh-utils history
  belak/zsh-utils completion
  chrissicool/zsh-bash
EOBUNDLES
antigen apply

source ~/dotfiles/zsh/platform-specific.zsh

eval "$(starship init zsh)"
