#*****************************************************************#
## Source Prezto.
 if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
   source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
#*****************************************************************#

## Zsh config and history

## History
##
HISTFILE=~/.zsh_history         # where to store zsh history
HISTSIZE=1024                   # big history
SAVEHIST=1024                   # big history
setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
setopt hist_verify              # show before executing history commands
setopt inc_append_history       # add commands as they are typed, do not wait until shell exit
#setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword
unsetopt correct_all
setopt CLOBBER

#Set zsh auto completion colors to dircolorsc
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

setopt NO_HUP
setopt NO_CHECK_JOBS
setopt print_exit_value

## You may need to manually set your language environment
export LANG=en_US.UTF-8

## Compilation flags
#export ARCHFLAGS="-arch x86_64"

## Set PATH of SSH key files
#export SSH_KEY_PATH="~/.ssh/id_rsa"

## For simple TERM prompt when in TTY
if [ $TERM = "linux" ]; then
      # simple prompt when in TTY
    PROMPT='%B%t%b %n@%m:%0~ $ '
fi

## Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

## User configuration
export PATH=/opt/edirect:$HOME/.bin:/usr/local/bin:$PATH
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
export LIBVA_DRIVER_NAME=i965

## Enable color support of ls and file types
if [ "$TERM" != "dumb" ]; then
        eval "`dircolors -b ~/.config/dircolors/dircolorsrc_srs`"
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
fi

## Various aliases

alias ws_2_underscore='for f in *\ *; do mv "$f" "${f// /_}"; done'

alias sx='startx -- -keeptty -nolisten tcp > /tmp/xsession-errors.log 2>&1'

alias upstream_git_update='git pull upstream master && git push origin master && git pull origin master'

alias enabled_units='systemctl list-unit-files | grep enabled'

alias restart_udev='sudo udevadm control --reload'
alias view_recent_alerts='sudo journalctl -p err..alert -b'
alias fw_clear='sudo iptables-restore < /etc/iptables/empty.rules'
alias fill_batteries_up="sudo tlp fullcharge"
alias rfkill="sudo rfkill"

alias pacupg='sudo pacman -Syyu'      # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacin='sudo pacman -S'         # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'        # Install specific package not from the repositories but from a file
alias pacre='sudo pacman -R'         # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'      # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'            # Display information about a given package in the repositories
alias pacreps='pacman -Ss'           # Search for package(s) in the repositories
alias pacloc='pacman -Qi'            # Display information about a given package in the local database
alias paclocs='pacman -Qs'           # Search for package(s) in the local database
alias paclo="pacman -Qdt"            # List all packages which are orphaned
alias pacc="sudo pacman -Scc"        # Clean cache - delete all not currently installed package files
alias paclf="pacman -Ql"             # List all files installed by a given package
alias pacexpl="pacman -D --asexp"    # Mark one or more installed packages as explicitly installed 
alias pacimpl="pacman -D --asdep"    # Mark one or more installed packages as non explicitly installed
alias install_size="/usr/bin/expac -Q '%m' -H M | /usr/bin/datamash -W sum 1"

alias l='ls -Flh'
alias ll='ls -Falh'
alias history='history -E'
alias clear='clear -x'

alias mnt_office_intel="sshfs srsantos@office_intel:/Users/srsantos /home/srsantos/Documents/Remote_FS/Office_intel && /usr/bin/notify-send -u low 'Remote FS Mounted' 'Now accessible.' -i /usr/share/icons/gnome-colors-common/scalable/places/network-server.svg"
alias mnt_ubuntu_server="sshfs srsantos@ubuntu_server:/home/srsantos /home/srsantos/Documents/Remote_FS/Ubuntu_server && /usr/bin/notify-send -u low 'Remote FS Mounted' 'Now accessible.' -i /usr/share/icons/gnome-colors-common/scalable/places/network-server.svg"
alias umnt_office_intel="fusermount -u /home/srsantos/Documents/Remote_FS/Office_intel && /usr/bin/notify-send -u low 'Remote FS Unmounted' 'Bye, Bye.' -i /usr/share/icons/gnome-colors-common/scalable/places/network-server.svg"
alias umnt_ubuntu_server="fusermount -u /home/srsantos/Documents/Remote_FS/Ubuntu_server && /usr/bin/notify-send -u low 'Remote FS Unmounted' 'Bye, Bye.' -i /usr/share/icons/gnome-colors-common/scalable/places/network-server.svg"

alias ubuntu='ssh ubuntu'
alias office='ssh office'
alias skynet='ssh skynet'
alias cyberdyne='ssh cyberdyne'
alias dmc='ssh dmc'
alias uv='ssh uv'

alias open_secure_sd='sudo cryptsetup luksOpen /dev/mmcblk0p1 secure_sd'
alias close_secure_sd='sudo cryptsetup luksClose secure_sd'
alias open_secure_usb='sudo cryptsetup luksOpen /dev/sdc secure_usb'
alias close_secure_usb='sudo cryptsetup luksClose secure_usb'

alias battery_level='cat /sys/class/power_supply/BAT0/uevent | grep POWER_SUPPLY_CAPACITY='
alias i3_exit='i3-msg exit'
alias sys-info='inxi -Fxz'
alias screenfetch='neofetch'
alias less='less -e -i -M -R -q'
alias sm_readers_ls='opensc-tool -l'

alias update_prezto='cd $ZPREZTODIR && git pull && git submodule update --init --recursive && cd ~'

alias rm_DS_Stores='find . -name ".DS_Store" -delete'

alias pulseaudio-ctl='/usr/local/bin/pulseaudio-ctl_local'

alias music_mpv_random_playlist="/usr/bin/termite --title music_mpv --hold --exec '/usr/bin/mpv --no-video --shuffle /home/srsantos/Music' &"
##alias music_mpv_random_playlist='mpv --no-video --shuffle --playlist <(find "$PWD" -type f)'

alias webcam_screenshot='mpv av://v4l2:/dev/video0'
alias webcam_mencoder_video='mencoder tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0:forceaudio:immediatemode=0:alsa:adevice=hw.0,0 -ofps 30 -ovc lavc -lavcopts vcodec=mjpeg -oac mp3lame -lameopts cbr:br=64:mode=3 -o'
alias webcam_ffmpeg_video='ffmpeg -f v4l2 -video_size 640x480 -thread_queue_size 1024 -pixel_format uyvy422 -framerate 29.97 -i /dev/video0 -f alsa -thread_queue_size 1024 -i hw:0,0 -acodec libmp3lame -ab 96k -c:v libx264 -aspect 4:3 -strict -2 -y -threads 4'

## Export variables
export PAGER='vimpager'
export EDITOR='vim'
export GCC_COLORS='error=01;38;5;160:warning=01;38;5;220:note=01;38;5;10:caret=01;38;5;33:locus=01:quote=01'
export GREP_OPTIONS=
export GREP_COLORS='fn=00;38;5;33:mc=00;36:ms=31:mt=01;38;5;200:ln=01;38;5;14'

# Set lesspipe.sh for viewing PDFs in less
LESSOPEN="|lesspipe.sh %s"; export LESSOPEN

##################################################################################

## Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

## Set GPG TTY
export GPG_TTY=$(tty)

## Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

##################################################################################

## Fan control
function fan() {
  sensors
  echo level $@ | sudo tee /proc/acpi/ibm/fan
}

