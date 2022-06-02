
case $(uname) in
  Linux)
	# do nothing
  ;;
  Darwin)
	eval "$(/opt/homebrew/bin/brew shellenv)"
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  ;;
esac
