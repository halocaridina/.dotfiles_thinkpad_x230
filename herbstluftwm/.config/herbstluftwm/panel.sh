#!/usr/bin/env bash

hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format W H X Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_height=18
font="-xos4-terminus-medium-*-*-*-12-*-*-*-*-*-*-*"
bgcolor='#1B1B1B'  ## use #222222 to match termite background
selbg=$(hc get window_border_active_color)
selfg='#FFFFFF'

####
# Try to find textwidth binary.
# In e.g. Ubuntu, this is named dzen2-textwidth.
if which textwidth &> /dev/null ; then
    textwidth="textwidth";
elif which dzen2-textwidth &> /dev/null ; then
    textwidth="dzen2-textwidth";
else
    echo "This script requires the textwidth tool of the dzen2 project."
    exit 1
fi
####
# true if we are using the svn version of dzen2
# depending on version/distribution, this seems to have version strings like
# "dzen-" or "dzen-x.x.x-svn"
if dzen2 -v 2>&1 | head -n 1 | grep -q '^dzen-\([^,]*-svn\|\),'; then
    dzen2_svn="true"
else
    dzen2_svn=""
fi

if awk -Wv 2>/dev/null | head -1 | grep -q '^mawk'; then
    # mawk needs "-W interactive" to line-buffer stdout correctly
    # http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=593504
    uniq_linebuffered() {
      awk -W interactive '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
else
    # other awk versions (e.g. gawk) issue a warning with "-W interactive", so
    # we don't want to use it there.
    uniq_linebuffered() {
      awk '$0 != l { print ; l=$0 ; fflush(); }' "$@"
    }
fi

hc pad $monitor $panel_height

{
    ### Event generator ###
    # based on different input data (mpc, date, hlwm hooks, ...) this generates events, formed like this:
    #   <eventname>\t<data> [...]
    # e.g.
    #   date    ^fg(#efefef)18:33^fg(#909090), 2013-10-^fg(#efefef)29

    #mpc idleloop player &
    while true ; do
        # "date" output is checked once a second, but an event is only
        # generated if the output changed compared to the previous run.
        date +$'date\t^fg(#efefef)%I:%M %p^fg(#909090) %Y-%m-^fg(#efefef)%d'
        sleep 1 || break
    done > >(uniq_linebuffered) &
    childpid=$!
    hc --idle
    kill $childpid
} 2> /dev/null | {
    IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
    visible=true
    date=""
    windowtitle=""
    network_icon=""
    brightness_icon=""
    brightness=""
    vol_icon=""
    volume=""
    power_state_icon=""
    battery=""
    while true ; do

        ### Output ###
        # This part prints dzen data based on the _previous_ data handling run,
        # and then waits for the next event to happen.
        bordercolor="#26221C"
        separator="^bg()^fg($selbg)|"
        # draw tags
        for i in "${tags[@]}" ; do
            case ${i:0:1} in
                '#')
                    echo -n "^bg($selbg)^fg($selfg)"
                    ;;
                '+')
                    echo -n "^bg(#9CA668)^fg(#141414)"
                    ;;
                ':')
                    echo -n "^bg()^fg(#ffffff)"
                    ;;
                '!')
                    echo -n "^bg(#EF2929)^fg(#141414)"
                    ;;
                *)
                    echo -n "^bg()^fg(#ababab)"
                    ;;
            esac
            case ${i:1} in
                '1')
                    icon="^fn(Droid Sans Japanese:size=11)一^fn()"
                    ;;
                '2')
                    icon="^fn(Droid Sans Japanese:size=11)二^fn()"
                    ;;
                '3')
                    icon="^fn(Droid Sans Japanese:size=11)三^fn()"
                    ;;
                '4')
                    icon="^fn(Droid Sans Japanese:size=11)四^fn()"
                    ;;
                '5')
                    icon="^fn(Droid Sans Japanese:size=11)五^fn()"
                    ;;
                '6')
                    icon="^fn(Droid Sans Japanese:size=11)六^fn()"
                    ;;
                '7')
                    icon="^fn(Droid Sans Japanese:size=11)七^fn()"
                    ;;
                '8')
                    icon="^fn()^fn(DejaVuSansMono Nerd Font:style=Book:size=14)^fn()"
                    ;;
                '9')
                    icon="^fn()^fn(DejaVuSansMono Nerd Font:style=Book:size=14)^fn()"
                    ;;
            esac
            # If tag is not empty, show it.
            if [[ "${i:0:1}" != '.' ]]; then
                # For clickable tags
                echo -n "^ca(1,herbstclient focus_monitor $monitor && herbstclient use ${i:1}) $icon ^ca()"
                # For non-clickable tags
                # echo -n " ${i:1} "
            fi
        done
        echo -n "$separator"
        echo -n "^bg()^fg() ${windowtitle//^/^^}"
        # Set up panel information
        # Network connectivity
        net_connection=`/usr/bin/ip route get 8.8.8.8 | head -1 | awk '{print $7}' 2> /dev/null`
        if [[ !  -z  $net_connection  ]]; then
            network_icon="^fg()^fg(#8AE234)^fn(DejaVuSansMono Nerd Font:style=Book:size=15)^fn()^fg(#8AE234)"
        else
            network_icon="^fg()^fg(#EF2929)^fn(DejaVuSansMono Nerd Font:style=Book:size=15)^fn()^fg(#EF2929)"
        fi
        # Volume
        mute=`/usr/bin/pulseaudio-ctl full-status | awk '{print $2}'`
        if [ ${mute} == "yes" ]; then
            volume="MUTE"
            vol_icon="^fg()^fg(#EF2929)^fn(DejaVuSansMono Nerd Font:style=Book:size=15)^fn()^fg(#EF2929)"
        else
            volume=$(/usr/bin/pulseaudio-ctl full-status | awk '{print $1}' | sed -e 's/$/%/')
            vol_icon="^fg()^fn(DejaVuSansMono Nerd Font:style=Book:size=15)^fn()"
        fi
        # Battery
        battery=`acpi -b | awk '{print $3 $4 $5}' | sed -e 's/,/ /g' -e 's/^\([A-Z]\)[a-z]*/\1/;s/U/PWR/;s/D/BAT/;s/C/CHR/' -e 's/:[0-9][0-9]$//'`
        power_state=`echo $battery | awk '{print $1}'`
        if [ ${power_state} == "PWR" ]; then
            power_state_icon="^fg()^fn(DejaVuSansMono Nerd Font:style=Book:size=13)^fn()"
        elif [ ${power_state} == "CHR" ]; then
            power_state_icon="^fg()^fg(#E5E500)^fn(DejaVuSansMono Nerd Font:style=Book:size=8)^fn()^fg(#E5E500)"
        else
            power_state_icon="^fg()^fg(#FFA500)^fn(DejaVuSansMono Nerd Font:style=Book:size=20)^fn()^fg(#FFA500)"
        fi
        # Brightness
        brightness=`/usr/bin/light -G | awk -F"." '{print $1}' | sed -e 's/$/%/'`
        brightness_icon="^fg()^fn(DejaVuSansMono Nerd Font:style=Book:size=9)^fn()"
        # Separator
        right="$separator^bg($hintcolor)^fg(#efefef)"
        # Put together indicator portion of panel
        if [ "$battery" != "/" ] ;then
            right="$right $network_icon $separator $brightness_icon $brightness $separator $vol_icon $volume $separator $power_state_icon $battery $separator ^fg(#efefef)"
        fi
        # Put together clock portion of panel
        clock_icon="^fn(DejaVuSansMono Nerd Font:style=Book:size=14)^fn()"
        right="$right $separator^fg() $clock_icon $date $separator"
        right_text_only=$(echo -n "$right" | sed 's.\^[^(]*([^)]*)..g')
        # get width of right aligned text.. and add some space for offset..
        width=$($textwidth "$font" "$right_text_only")
        offset=-26
        echo -n "^pa($(($panel_width - $width - $offset)))$right"
        echo

        ### Data handling ###
        # This part handles the events generated in the event loop, and sets
        # internal variables based on them. The event and its arguments are
        # read into the array cmd, then action is taken depending on the event
        # name.
        # "Special" events (quit_panel/togglehidepanel/reload) are also handled
        # here.

        # wait for next event
        IFS=$'\t' read -ra cmd || break
        # find out event origin
        case "${cmd[0]}" in
            tag*)
                echo "resetting tags" >&2
                IFS=$'\t' read -ra tags <<< "$(hc tag_status $monitor)"
                ;;
            date)
                echo "resetting date" >&2
                date="${cmd[@]:1}"
                ;;
            quit_panel)
                exit
                ;;
            togglehidepanel)
                currentmonidx=$(hc list_monitors | sed -n '/\[FOCUS\]$/s/:.*//p')
                if [ "${cmd[1]}" -ne "$monitor" ] ; then
                    continue
                fi
                if [ "${cmd[1]}" = "current" ] && [ "$currentmonidx" -ne "$monitor" ] ; then
                    continue
                fi
                echo "^togglehide()"
                if $visible ; then
                    visible=false
                    hc pad $monitor 0
                else
                    visible=true
                    hc pad $monitor $panel_height
                fi
                ;;
            reload)
                exit
                ;;
            focus_changed|window_title_changed)
                windowtitle="${cmd[@]:2}"
                ;;
        esac
    done

    ### dzen2 ###
    # After the data is gathered and processed, the output of the previous block
    # gets piped to dzen2.

} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y -fn "$font" -h $panel_height \
    -e 'button3=;button4=exec:herbstclient use_index -1;button5=exec:herbstclient use_index +1' \
    -ta l -bg "$bgcolor" -fg '#efefef'

