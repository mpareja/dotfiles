export DOTFILES=$(dirname $BASH_SOURCE)

. $DOTFILES/bash/env
. $DOTFILES/bash/config
. $DOTFILES/bash/aliases

. `find $DOTFILES -type f -maxdepth 2 -iname bash`

