#!/bin/bash
# volumecontrol up
# volumecontrol down
# volumecontrol mute
function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    dunstify -a "changeVolume" -u low -i audio-volume-high-symbolic -h string:x-dunst-stack-tag:$msgTag \
    -h int:value:"$volume" "Volume: ${volume}%"
    canberra-gtk-play -i audio-volume-change -d "changeVolume"
}


percentage=5
msgTag="myvolume"

case $1 in
    up)
        # Set the volume on (if it was muted)
        amixer -D pulse set Master on > /dev/null
        # Up the volume
        amixer -D pulse sset Master $percentage%+ > /dev/null
        send_notification
    ;;
    down)
        amixer -D pulse set Master on > /dev/null
        # Down the volume
        amixer -D pulse sset Master $percentage%- > /dev/null
        send_notification
    ;;
    mute)
        # Toggle mute
        volume=`get_volume`
        amixer -D pulse set Master 1+ toggle > /dev/null
        if is_mute ; then
            dunstify -a "changeVolume" -u low -i audio-volume-muted-symbolic -h string:x-dunst-stack-tag:$msgTag "Volume muted"
        else
            send_notification
        fi
    ;;
esac
