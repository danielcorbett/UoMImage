#!/bin/bash

VNCSERVICE=vncserver\@.service
VNCSERVICENUM=vncserver\@:0.service

yum install tigervnc-server -y
cp /lib/systemd/system/$VNCSERVICE /etc/systemd/system/$VNCSERVICE
sed -i 's/<USER>/vagrant/' /etc/systemd/system/$VNCSERVICE
systemctl daemon-reload
systemctl enable $VNCSERVICENUM
systemctl start $VNCSERVICENUM
