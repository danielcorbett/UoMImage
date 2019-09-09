# UoMImage Read Me

#Overview
The object of this repository is to have a single way to create disk images using a single set of files. The disk images currently use a kickstart file as their basis. That file is stored in the 'http' directory at the root repository level. This is currently used for centos 7 installations and is currently capable of building Docker and Virtualbox images.

Additions to any of the built images can be created by using the Bash scripts in the 'scripts' directory.


#Building Virtualbox Images
Making use of the main kickstart file, the program Packer is used to build the image. Packer makes use of JSON files and Vagrant.

To build a Virtualbox image the following command can be used...

	packer build ./vagrant-templates/template-base.json


#Building Docker Images
This can be done by using the scripts in the 'scripts/docker' directory. It requires the main kickstart file and optionally using the additions scripts. It also requires the livemedia-creator program and docker to be running in the background. It also requires the boot.iso which is available from the general Centos download repositories.
