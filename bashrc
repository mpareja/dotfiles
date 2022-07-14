export DOTFILES=$(dirname $BASH_SOURCE)

. $DOTFILES/bash/env
. $DOTFILES/bash/config
. $DOTFILES/bash/aliases

for f in $DOTFILES/*/bash; do source $f; done
