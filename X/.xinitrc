#!/bin/sh

# ░░░░█░█░▀█▀░█▀█░▀█▀░▀█▀░█▀▄░█▀▀
# ░░░░▄▀▄░░█░░█░█░░█░░░█░░█▀▄░█░░
# ░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀

# load some stuff.
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrdb -load "$HOME/.Xresources"
xsetroot -cursor_name left_ptr &
xset r rate 300 70 &
setxkbmap -option "caps:swapescape" &
nitrogen --restore &
dunst &
dwmblocks &
clipmenud &

# relaunch DWM if the binary changes, otherwise exit.
csum=$(sha1sum $(which dwm))
new_csum=""
while true
do
  if [ "$csum" != "$new_csum" ]
  then
      csum=$new_csum
      dwm 2> "$HOME/tmp/dwm.log"
  else
      exit 0
  fi
  new_csum=$(sha1sum $(which dwm))
  sleep 0.5
done
