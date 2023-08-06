
case $(uname) in
  Linux)
	  DISTRO=$(awk -F'=' '/^ID=/ {print tolower($2)}' /etc/*-release 2> /dev/null)
    if [ $DISTRO = "alpine" ]
    then
      source $HOME/src/antigen/antigen.zsh
    else
      # arch
      source /usr/share/zsh/share/antigen.zsh
    fi
  ;;
  Darwin)
    source /opt/homebrew/share/antigen/antigen.zsh
  ;;
esac
