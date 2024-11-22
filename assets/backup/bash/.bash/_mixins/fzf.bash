# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# [ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
# [ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

alias fzfp="fzf \
	--preview 'fzf-preview.sh {}' \
	--preview-window '~1:+{2}/2:noborder'"

export FZF_DEFAULT_OPTS='--ansi'

# fzf key binding
export FZF_CTRL_T_COMMAND='fd --hidden'

export FZF_ALT_C_COMMAND='fd --hidden --type dir'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" ;;
    export|unset) fzf "$@" ;;
    ssh)          fzf "$@" ;;
    *)            fzf "$@" ;;
  esac
}
