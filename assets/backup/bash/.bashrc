# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s histappend
# Automatically corrects minor spelling mistakes in the `cd` command
shopt -s cdspell
# Enable case sensitivity
shopt -s nocaseglob

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias code='code --ozone-platform=$XDG_SESSION_TYPE'
alias fars='curl -F "c=@-" "http://fars.ee/"'

# alias less='less -S +G'
# Open the command manual in browser by default
# alias man="man -Hgoogle-chrome-stable"
# alias man="man -Hfirefox"
# unset BROWSER

# Terminal Prompt Setting
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
function prompt_command {
    # history -a; history -c; history -r;
    echo -ne "\033]0;$USER@$(uname -n):$(basename "$PWD")\007\033[ q";
}
PROMPT_COMMAND=prompt_command

# Bash completion
[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion

# GPG Config
export GPG_TTY=$(tty)

source ~/.bash/_mixins/hist.bash
source ~/.bash/_mixins/fzf.bash
source ~/.bash/_mixins/nnn.bash

