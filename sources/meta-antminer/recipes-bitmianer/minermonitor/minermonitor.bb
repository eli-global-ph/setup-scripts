DESCRIPTION = "Daemon helloword"
LICENSE = "CLOSED"
#LICENSE = "GPL"
#LIC_FILES_CHKSUM = "file://COPYING;md5=d41d8cd98f00b204e9800998ecf8427e"

SRC_URI = "file://minermonitor-1.0/* \
	"

S = "${WORKDIR}/${PN}"
PACKAGES = "${PN}"

do_compile() {
	make 
}

do_install_append() {
	install -d ${D}${bindir}
	install -m 0755 ${S}/miner-monitor ${D}${bindir}/miner-monitor
}


