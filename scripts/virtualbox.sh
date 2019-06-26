VBOX_VERSION=$(cat /home/vagrant/.vbox_version)

# required for VirtualBox 4.3.26
#rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#yum install gcc dkms make bzip2 perl
#KERN_DIR=/usr/src/kernels/`uname -r`
#export KERN_DIR
#cd /tmp
#mount -o loop /home/vagrant/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
#sh /mnt/VBoxLinuxAdditions.run
#umount /mnt
#rm -rf /home/vagrant/VBoxGuestAdditions_*.iso

