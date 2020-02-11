#!/bin/bash

# Integration with ripgrep
RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY="$1"
FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --bind "change:reload:$RG_PREFIX {q} || true" \
    --ansi --phony --query "$INITIAL_QUERY"