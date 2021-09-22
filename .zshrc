#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source /usr/share/zsh/share/antigen.zsh

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

#SAVEHIST=1000  # Save most-recent 1000 lines
#HISTFILE=~/.zsh_history

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
	  eval `ssh-agent`
	    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

#alias ls='ls --color=auto'
#alias la='ls -la --color=auto'
#alias ll='ls -l --color=auto'

alias ua-drop-caches='sudo paccache -rk3; yay -Sc --aur --noconfirm'
alias ua-update-all='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
      && ua-drop-caches \
      && yay'

export PLATFORM_SDK_ROOT=/srv/mer
alias sfossdk=$PLATFORM_SDK_ROOT/sdks/sfossdk/mer-sdk-chroot

eval "$(starship init zsh)"
