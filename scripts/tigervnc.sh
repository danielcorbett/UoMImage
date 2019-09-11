#!/bin/bash

VNCSERVICE=vncserver\@.service
VNCSERVICENUM=vncserver\@:0.service

yum install tigervnc-server -y
cp /lib/systemd/system/$VNCSERVICE /etc/systemd/system/$VNCSERVICE
sed -i 's/<USER>/vagrant/' /etc/systemd/system/$VNCSERVICE
echo "<‰ôFmÂ¦z" > /home/vagrant/.vnc/passwd
chown -R vagrant /home/vagrant/.vnc
chmod 600 /home/vagrant/.vnc/passwd
systemctl daemon-reload
systemctl enable $VNCSERVICENUM
systemctl start $VNCSERVICENUM
