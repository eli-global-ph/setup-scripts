export IMAGE_BASENAME = "S9-antminer"
IMAGE_INSTALL = " \
	busybox \
	base-files \
	base-passwd \
	initscripts \
	sysvinit \
	sysvinit-pidof \
	angstrom-version \
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
	bitmain-spi-s3 \
"

#omap3-mkcard 			   
#cgminer 

inherit image

do_rootfs_append() {
	echo "do_build_append"
}

