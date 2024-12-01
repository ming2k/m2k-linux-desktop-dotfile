# ~/.zshrc

# Create directory for zsh plugins if it doesn't exist
if [[ ! -d ~/.zsh ]]; then
    mkdir -p ~/.zsh
fi

# Download and set up plugins if they don't exist
if [[ ! -d ~/.zsh/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi

if [[ ! -d ~/.zsh/zsh-completions ]]; then
    git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
fi
# Add zsh-completions to fpath
fpath=(~/.zsh/zsh-completions/src $fpath)

# Completion system initialization
autoload -Uz compinit
compinit
# Enhanced completion styles
zstyle ':completion:*' menu select # enable completion menu

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'
setopt PROMPT_SUBST
PROMPT='%~ ${vcs_info_msg_0_} $ '

# Aliases
alias firefox='firefox-bin'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias code='code --ozone-platform=$XDG_SESSION_TYPE'
alias fars='curl -F "c=@-" "http://fars.ee/"'

# Prompt Setting (using zsh format)
# PS1='%F{blue}%n%f@%F{yellow}%m%f:%F{green}%1~%f$ '
PS1='%F{green}%n@%m%f:%F{blue}%~%f$ '

# Terminal title setting
precmd() {
    print -Pn "\e]0;%n@%m:%1~\a\e[ q"
}

# GPG Config
export GPG_TTY=$(tty)

# Load syntax highlighting (must be at the end)
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# source ~/.zsh/_mixins/common.zsh
# source ~/.zsh/_mixins/autosuggest.zsh
# source ~/.zsh/_mixins/fzf.zsh
# source ~/.zsh/_mixins/nnn.zsh

