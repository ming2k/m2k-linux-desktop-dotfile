# nnn configuration
export NNN_PLUG='p:preview-tui'  # Preview plugin
export NNN_FIFO="/tmp/nnn.fifo"  # FIFO for preview
export NNN_COLORS="2136"         # Custom colors
export NNN_FCOLORS='c1e2272e006033f7c6d6abc4'  # File colors

# Create preview FIFO if it doesn't exist
[ ! -p "$NNN_FIFO" ] && mkfifo "$NNN_FIFO"

# nnn cd on quit
n ()
{
    # Block nnn if NNNLVL is greater than 1
    if [ -n "$NNNLVL" ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn -a "$@"

    if [ -f "$NNN_TMPFILE" ]; then
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# Key bindings
bindkey -s ';p' 'nnn -P p\n'  # Bind ;p to open nnn with preview
