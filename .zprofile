
case $(uname) in
  Linux)
	source .profile
  ;;
  Darwin)
	eval "$(/opt/homebrew/bin/brew shellenv)"
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  ;;
esac
