
case $(uname) in
  Linux)
	# do nothing
  ;;
  Darwin)
	eval "$(/opt/homebrew/bin/brew shellenv)"
  ;;
esac
