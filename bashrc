export DOTFILES=$(dirname $BASH_SOURCE)

. $DOTFILES/bash/env
. $DOTFILES/bash/config
. $DOTFILES/bash/aliases

. `find $DOTFILES -maxdepth 2 -type f -iname bash`

