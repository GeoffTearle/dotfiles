# setup ssh agent
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
	  eval `ssh-agent`
	    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# rate mirrors alias's
alias ua-drop-caches='sudo paccache -rk3; yay -Sc --aur --noconfirm'
alias ua-update-all='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
      && ua-drop-caches \
      && yay'

alias yay-remove-orphans='yay -Qtdq | yay -Rns -'

export PLATFORM_SDK_ROOT=/srv/mer
alias sfossdk=$PLATFORM_SDK_ROOT/sdks/sfossdk/mer-sdk-chroot
alias sfdk=$HOME/SailfishOS/bin/sfdk
export PATH=$PATH:~/.local/bin

autoload bashcompinit
bashcompinit
eval "$(register-python-argcomplete pmbootstrap)"
