# History settings
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

setopt AUTO_CD
setopt EXTENDED_GLOB
setopt PROMPT_SUBST
setopt NO_NOMATCH

setopt globdots				# include dot file for completion
setopt COMPLETE_IN_WORD		# Complete from both ends of a word
setopt ALWAYS_TO_END		# Move cursor to the end of a completed word
setopt PATH_DIRS			# Perform path search even on command names with slashes
setopt AUTO_MENU			# Show completion menu on a successive tab press
setopt AUTO_LIST			# Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH		# If completed parameter is a directory, add a trailing slash

# Key bindings for autosuggestions
bindkey "^[[1~" beginning-of-line	# HOME KEY
bindkey "^[[4~" end-of-line			# END KEY
bindkey "^[[1;5D" backward-word     # CTRL + LEFT
bindkey "^[[1;5C" forward-word      # CTRL + RIGHT
bindkey '^H' backward-kill-word     # CTRL + BACKSPACE
bindkey '^[[3;5~' kill-word         # CTRL + DELETE

