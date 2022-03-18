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
	spitools \
"
#omap3-mkcard 			   
#cgminer 

inherit image

EXPORTED_TMPIMAGE = "initramfs"
DEFAULT_SYS_PASSWORD = "rex"

do_rootfs_append() {
	echo "do_build_append"

	# create directory and files for SD type image
	echo ${DEFAULT_SYS_PASSWORD} | sudo -S -k mkdir -p /tftpboot

	if [ -f "/tftpboot/${EXPORTED_TMPIMAGE}.bin" ]; 
		then echo ${DEFAULT_SYS_PASSWORD} | sudo -S -k rm -rf /tftpboot/${EXPORTED_TMPIMAGE}.bin &&
		echo ${DEFAULT_SYS_PASSWORD} | sudo -S -k touch /tftpboot/${EXPORTED_TMPIMAGE}.bin
	else 
		echo ${DEFAULT_SYS_PASSWORD} | sudo -S -k touch /tftpboot/${EXPORTED_TMPIMAGE}.bin
	fi

	if [ -f "/tftpboot/${EXPORTED_TMPIMAGE}.bin.SD" ];
		then echo ${DEFAULT_SYS_PASSWORD} | sudo -S -k rm -rf /tftpboot/${EXPORTED_TMPIMAGE}.bin.SD &&
		echo ${DEFAULT_SYS_PASSWORD} | sudo -S -k touch /tftpboot/${EXPORTED_TMPIMAGE}.bin.SD
	else 
		echo ${DEFAULT_SYS_PASSWORD} | sudo -S -k touch /tftpboot/${EXPORTED_TMPIMAGE}.bin.SD
	fi
	echo ${DEFAULT_SYS_PASSWORD} | sudo -S -k cp -rf ${DEPLOY_DIR_IMAGE}/Angstrom-antminer-eglibc-ipk-v2013.12-beaglebone.rootfs.cpio.gz.u-boot /tftpboot/${EXPORTED_TMPIMAGE}.bin
	echo ${DEFAULT_SYS_PASSWORD} | sudo -S -k cp -rf ${DEPLOY_DIR_IMAGE}/Angstrom-antminer-eglibc-ipk-v2013.12-beaglebone.rootfs.cpio.gz.u-boot /tftpboot/${EXPORTED_TMPIMAGE}.bin.SD
}

