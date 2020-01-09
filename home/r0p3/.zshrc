# to set zsh as default write "chsh -s $(which zsh)" and reboot the system
# Enable colors and change prompt:
autoload -U colors && colors
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# - - - Pure Prompt - - -
autoload -Uz promptinit
promptinit
prompt pure
# plugins=(git)


# - - - Custom Prompt - - -
# PS1="%F{166}%n%f%F{166}@%f%F{166}%M%f : %F{031}%~%f
# $ > "
# https://gist.github.com/LukeSmithxyz/e62f26e55ea8b0ed41a65912fbebbe52
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# Print void line to make space between commands
# https://stackoverflow.com/questions/20512957/zsh-new-line-prompt-after-each-command
# precmd() { print "" }
# function precmd {
    # if [[ "$NEW_LINE" = true ]] then
        # if [[ "${ADD_NEW_LINE}" = true ]] then
            # PROMPT=$'\n'"${PROMPT}"
            # ADD_NEW_LINE=false
        # fi
    # else
        # PROMPT="${PROMPT}"
        # NEW_LINE=true
        # ADD_NEW_LINE=true
    # fi
# }
# function precmd() {
    # # Print a newline before the prompt, unless it's the
    # # first prompt in the process.
    # if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        # NEW_LINE_BEFORE_PROMPT=1
    # elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        # echo "\n"
    # fi
# }

# - - - Initial config - - -
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
# bindkey -v
# export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# - - - Alias - - -
alias ll='ls -laF --color'
alias py='python3'
alias :q='exit'

# Configuration
alias edit-bspwm='nvim ~/.config/bspwm/bspwmrc'
alias edit-coc='nvim ~/.config/nvim/coc-settings.json'
alias edit-kitty='nvim ~/.config/kitty/kitty.conf'
alias edit-lightdm='sudo nvim /etc/lightdm/lightdm.conf'
alias edit-nvim='nvim ~/.config/nvim/init.vim'
alias edit-polybar='nvim ~/.config/polybar/config'
alias edit-polylaunch='nvim ~/.config/polybar/launch.sh'
alias edit-rofi='nvim ~/.config/rofi/full.rasi'
alias edit-sxhkd='nvim ~/.config/sxhkd/sxhkdrc'
alias edit-webkit2='sudo nvim /etc/lightdm/lightdm-webkit2-greeter.conf'
alias edit-xprofile='nvim ~/.xprofile'
alias edit-zsh='nvim ~/.zshrc'
alias edit-thinkfan='sudo nvim /etc/thinkfan.conf'
alias edit-compton='nvim ~/.config/compton.conf'
alias edit-clearine='nvim ~/.config/clearine.conf'
alias edit-betterockscreen='nvim ~/.config/betterlockscreenrc'
alias load-average="uptime | grep -ohe 'load average[s:][: ].*' | awk '{ print $3" "$4" "$5"," }' | sed 's/,//g'"

# - - - System - - -
alias sysenable='systemctl list-unit-files --state=enabled'
alias memused="free -h|awk '/^Mem:/ {print $3  $2}'"
alias cputemp="sensors|awk '/^temp1/ {print $2}'"
alias topmem='ps axch -o cmd:15,%mem --sort=-%mem|head'
alias topcpu='ps axch -o cmd:15,%cpu --sort=-%mem|head'


# Show last 10 programs installeds, orphan packages and the cache
# Used in zsh
function clean
{
  if [ -z $1 ]; then num=10; else num=$1; fi;
  echo "LAST $num INSTALLED PACKAGES:"
  history 0 | tac | grep -m $num -e " sudo pacman -S " -e " yay -S " -e " pip3 #install "
  echo "ORPHAN PACKAGES:"
  yay -Qqtd
  echo "CACHE CLEANING:"
  paccache -v -d
}

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
