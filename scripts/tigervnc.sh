#!/bin/bash

export DISPLAY=$HOSTNAME:0

yum install novnc xorg-x11-xinit tigervnc-server xterm xfce4-panel xfwm4 -y
/usr/bin/novnc_server --vnc localhost:5901 --listen 6901 &

xinit -- /usr/bin/Xvnc :0 -auth /root/.Xauthority -depth 24 -desktop $HOSTNAME:0 -fp /usr/share/fonts/X11//misc,/usr/share/fonts/X11//Type1 -geometry 1280x1024 -pn -SecurityTypes=none -rfbport 5901 -rfbwait 30000 -NeverShared &   

/usr/bin/xfce4-panel &

/usr/bin/xfwm4 &
