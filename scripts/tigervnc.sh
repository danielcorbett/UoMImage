#!/bin/bash

VNCSERVICE=vncserver\@.service

yum install tigervnc-server -y
cp /lib/systemd/system/$VNCSERVICE /etc/systemd/system/$VNCSERVICE
sed -i 's/<USER>/vagrant/' /etc/systemd/system/$VNCSERVICE
systemctl daemon-reload
systemctl enable $VNCSERVICE
systemctl start $VNCSERVICE
