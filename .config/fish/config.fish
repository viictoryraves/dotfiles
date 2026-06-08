source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# Pi
fish_add_path "/home/manuel/.local/share/pi-node/node-v22.22.3-linux-x64/bin"

# Aliases
alias vi="nvim"
alias vim="nvim"
alias cl="claude"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
