#!/bin/bash

rg -Nl -- '#!/bin/bash' | fzf --tac --exact --header="Bash scripts in $PWD | <Enter> = open $EDITOR selected | <ESC> = exit" --bind "enter:execute($EDITOR {})" --ansi --preview='bat {} --style=full --color=always;shellcheck --color=always {}' --cycle --border
