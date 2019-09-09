# This is a minimal CentOS kickstart designed for docker. 
# It will not produce a bootable system 
# To use this kickstart, run the following command
# livemedia-creator --make-tar \
#   --iso=/path/to/boot.iso  \
#   --ks=centos-7.ks \
#   --image-name=centos-root.tar.xz
#
# Once the image has been generated, it can be imported into docker
# by using: cat centos-root.tar.xz | docker import -i imagename

# Basic setup information
url --url="http://mirrors.kernel.org/centos/7/os/x86_64/"
install
#cdrom
lang en_GB.UTF-8
keyboard uk
network --bootproto=dhcp --device=ens3 --activate --onboot=on --noipv6
rootpw --plaintext vagrant
authconfig --enableshadow --passalgo=sha512
selinux --permissive
timezone Europe/London
bootloader --location=mbr --driveorder=sda --append="crashkernel=128M rhgb"
eula --agreed
repo --name="CentOS" --baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch/ --cost=100
repo --name="Updates" --baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch/ --cost=100
#text
skipx
zerombr

ignoredisk --only-use=sda
clearpart --all --initlabel --drives=sda
bootloader --location=mbr
part /boot --fstype ext4 --size=512 --ondisk=sda
part pv.01 --size=8000 --grow --ondisk=sda
volgroup VolGroup --pesize=8192 pv.01
logvol / --vgname=VolGroup --fstype ext4 --size=4096 --name=lv_root
logvol swap --vgname=VolGroup --fstype swap --name=lv_swap --hibernation --size=2048

auth --useshadow --enablemd5
firstboot --disabled
reboot

%packages --ignoremissing --nocore
bash
bzip2
kernel-devel
kernel-headers
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
wget
emacs
curl
rsync
bind-utils
bash
yum
vim-minimal
centos-release
less
-kernel*
-*firmware
-os-prober
-gettext*
-bind-license
-freetype
iputils
iproute
systemd
rootfiles
-libteam
-teamd
tar
passwd
%end

%post
/usr/bin/yum -y update
/usr/bin/yum -y install sudo
/usr/sbin/groupadd -g 501 vagrant
/usr/sbin/useradd vagrant -u 501 -g vagrant -G wheel
echo "vagrant"|passwd --stdin vagrant
echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
echo "Defaults:vagrant !requiretty"                 >> /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant


###  Script base-nogui.sh  ###

sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
yum -y install gcc make gcc-c++ kernel-devel-`uname -r` perl grub2-tools net-tools
yum -y install epel-release.noarch


###  Script anaconda.sh  ###

# download and install
wget --quiet https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh -O /tmp/anaconda.sh
BASE=/opt/apps
mkdir -p $BASE
bash /tmp/anaconda.sh -b -p $BASE/anaconda
rm /tmp/anaconda.sh
export PATH=$BASE/anaconda/bin:$PATH # add to PATH
echo 'export PATH=$BASE/anaconda/bin:$PATH' >> /etc/bashrc
hash -r

# some configuration to make it easy to install things
conda config --set always_yes yes --set changeps1 no
conda update -q conda

# add channels to look for packages
conda config --add channels r # for backward compatibility with old r packages
conda config --add channels defaults
conda config --add channels conda-forge # additional common tools
conda config --add channels bioconda # useful bioinformatics

conda install -n root _license

# display info
conda info -a
sync


###  Script vagrant.sh  ###

date > /etc/vagrant_box_build_time

mkdir -pm 700 /home/vagrant/.ssh
curl -L https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh


###  Script cleanup.sh  ###

yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y clean all
#rm -rf VBoxGuestAdditions_*.iso
rm -rf /tmp/rubygems-*
%end
