# !/bin/bash

SPEAKER_TV="alsa_output.pci-0000_09_00.1.hdmi-stereo-extra2"
SPEAKER_DESK="alsa_output.usb-Logitech_G533_Gaming_Headset-00.analog-stereo"

if test -f "desk"
then
    # swap to TV
    xrandr --output DP-0 --off \
        --output HDMI-1 --mode 3840x2160 --pos 0x0 --rotate normal --rate 60 --primary
    gsettings set org.gnome.desktop.interface text-scaling-factor 1.5
    pacmd set-default-sink $SPEAKER_TV
    pacmd set-sink-volume $SPEAKER_TV 0x10000 # 100% volume
    rm desk
else
    # swap to desk
    xrandr --output HDMI-1 --off \
	--output DP-0 --mode 3840x1080 --pos 0x0 --rotate normal --rate 144 --primary
    pacmd set-default-sink $SPEAKER_DESK
    gsettings set org.gnome.desktop.interface text-scaling-factor 1
    pacmd set-sink-volume $SPEAKER_DESK 0x4000 # 40% volume
    touch desk
fi
