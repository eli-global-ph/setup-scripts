export IMAGE_BASENAME = "antminer"
IMAGE_INSTALL = " \
	busybox \
	base-files \
	base-passwd \
	initscripts \
	sysvinit \
	sysvinit-pidof \
	angstrom-version \
	tinylogin \
	i2c-tools \
	screen \
	dropbear \
	libcurl \
	lighttpd \
	dtc \
	stunnel \
	initc-bin \
	openssl \
	mtd-utils \
	curl \
	udev \
	monitor-recobtn \
	test-btn \
	ntp \
	ntpdate \
	netbase \
	avahi \
	led-blink \
	cgminer \
"
#omap3-mkcard 			   
#cgminer 

inherit image

do_rootfs_append() {
	echo "do_build_append"
	sudo cp -rf /home/rex/setup-scripts/deploy/eglibc/images/beaglebone/Angstrom-antminer-eglibc-ipk-v2013.12-beaglebone.rootfs.tar.xz /tftpboot/initramfs.bin
	sudo cp -rf /home/rex/setup-scripts/deploy/eglibc/images/beaglebone/Angstrom-antminer-eglibc-ipk-v2013.12-beaglebone.rootfs.tar.xz /tftpboot/initramfs.bin.SD
}

