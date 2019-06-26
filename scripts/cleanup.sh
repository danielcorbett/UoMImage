#!/bin/bash
yum groupinstall "X Window System" -y
yum groupinstall "MATE Desktop" -y
yum install "xorg*" -y
yum install "lightdm" -y
unlink /etc/systemd/system/default.target
ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
yum -y clean all
rm -rf VBoxGuestAdditions_*.iso
rm -rf /tmp/rubygems-*
systemctl set-default graphical.target
systemctl enable lightdm.service
