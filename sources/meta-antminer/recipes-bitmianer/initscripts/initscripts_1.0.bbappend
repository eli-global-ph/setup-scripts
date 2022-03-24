FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}-1.0:"

PRINC := "${@int(PRINC) + 1}"

SRC_URI += "\
	file://mountdevtmpfs.sh \
	file://network.sh \
	file://network.conf.factory \
	file://network_c1.conf.factory \
	file://cgminer.sh \
	file://bmminer.conf.factory \
	file://cgminer_c1.conf.factory \
	file://cgminer_c2.conf.factory \
	file://cgminer_s4p.conf.factory \
	file://cgminer_s5.conf.factory \
	file://cgminer_s5p.conf.factory \
	file://cgminer_s2.conf.factory \
	file://cgminer_s9k.conf.factory \
	file://user_setting.factory \
	file://user_defined_lcd.factory \
	file://ntpdate.sh \
	file://shadow.factory \
	file://bitmainer_setup.sh \
	file://monitorcg \
	file://miner_lcd.sh \
	file://pgnand.sh \
	file://auto_freq.sh \
	file://auto_freq.conf \
	file://miner-m.sh \
	file://dataformatconfig \
	file://minermonitor.conf \
	file://minermonitor \
	file://config/ \
"

do_install_append() {
	install -m 0755 ${WORKDIR}/mountdevtmpfs.sh ${D}${sysconfdir}/init.d
	update-rc.d -r ${D} mountdevtmpfs.sh start 02 S .

	install -m 0755 ${WORKDIR}/network.sh ${D}${sysconfdir}/init.d
	update-rc.d -r ${D} network.sh start 38 S .

	install -m 0755 ${WORKDIR}/bitmainer_setup.sh ${D}${sysconfdir}/init.d
	update-rc.d -r ${D} bitmainer_setup.sh start 37 S .

	install -m 0755 ${WORKDIR}/ntpdate.sh ${D}${sysconfdir}/init.d
	update-rc.d -r ${D} ntpdate.sh start 39 S .

	install -m 0755 ${WORKDIR}/cgminer.sh ${D}${sysconfdir}/init.d
	update-rc.d -r ${D} cgminer.sh start 70 S .

	install -m 0755 ${WORKDIR}/pgnand.sh ${D}${sysconfdir}/init.d
	
	cd ${D}${sysconfdir}/rcS.d
	ln -s ../init.d/ntpd S40ntpd
	
	if [ x"YES" == x"${Miner_Monitor}" ]; then
	install -m 0755 ${WORKDIR}/minermonitor ${D}${sysconfdir}/init.d
        update-rc.d -r ${D} minermonitor start 100 S .

        install -m 0400 ${WORKDIR}/minermonitor.conf  ${D}${sysconfdir}/minermonitor.conf.factory
        install -d ${D}${sysconfdir}/dataformatconfig
	install -m 0400 ${WORKDIR}/dataformatconfig/*  ${D}${sysconfdir}/dataformatconfig/
        #cp -rf ${WORKDIR}/dataformatconfig  ${D}${sysconfdir}/

	install -d ${D}${base_sbindir}
        install -m 0755 ${WORKDIR}/miner-m.sh ${D}${base_sbindir}/

	#install -d ${D}${base_sbindir}
        #install -m 0755 ${WORKDIR}/d-ddos-m.sh ${D}${base_sbindir}/
        

	fi

        install -d ${D}${base_sbindir}
        install -m 0755 ${WORKDIR}/auto_freq.sh ${D}${base_sbindir}/
	install -m 0400 ${WORKDIR}/auto_freq.conf ${D}${sysconfdir}/auto_freq.conf.factory

	install -m 0400 ${WORKDIR}/shadow.factory ${D}${sysconfdir}/shadow.factory
	if [ x"C1" == x"${Miner_TYPE}" ]; then
		install -m 0400 ${WORKDIR}/network_c1.conf.factory ${D}${sysconfdir}/network.conf.factory
		install -m 0400 ${WORKDIR}/cgminer_c1.conf.factory ${D}${sysconfdir}/bmminer.conf.factory
	elif [ x"C2" == x"${Miner_TYPE}" ]; then
		install -m 0400 ${WORKDIR}/network_c1.conf.factory ${D}${sysconfdir}/network.conf.factory
		install -m 0400 ${WORKDIR}/cgminer_c2.conf.factory ${D}${sysconfdir}/bmminer.conf.factory
	elif [ x"S5" == x"${Miner_TYPE}" ]; then
		install -m 0400 ${WORKDIR}/network.conf.factory ${D}${sysconfdir}/network.conf.factory
		install -m 0400 ${WORKDIR}/cgminer_s5.conf.factory ${D}${sysconfdir}/bmminer.conf.factory
	elif [ x"S2" == x"${Miner_TYPE}" ]; then
		echo "AntMiner ${Miner_TYPE}" > ${WORKDIR}/user_defined_lcd.factory
		install -m 0400 ${WORKDIR}/network.conf.factory ${D}${sysconfdir}/network.conf.factory
		install -m 0400 ${WORKDIR}/cgminer_s2.conf.factory ${D}${sysconfdir}/bmminer.conf.factory
	elif [ x"S4+" == x"${Miner_TYPE}" ]; then
		echo "AntMiner ${Miner_TYPE}" > ${WORKDIR}/user_defined_lcd.factory
		install -m 0400 ${WORKDIR}/network.conf.factory ${D}${sysconfdir}/network.conf.factory
		install -m 0400 ${WORKDIR}/cgminer_s4p.conf.factory ${D}${sysconfdir}/bmminer.conf.factory
	elif [ x"S5+" == x"${Miner_TYPE}" ]; then
		install -m 0400 ${WORKDIR}/network.conf.factory ${D}${sysconfdir}/network.conf.factory
		install -m 0400 ${WORKDIR}/cgminer_s5p.conf.factory ${D}${sysconfdir}/bmminer.conf.factory
	elif [ x"S9k" == x"${Miner_TYPE}" ]; then
		install -m 0400 ${WORKDIR}/network.conf.factory ${D}${sysconfdir}/network.conf.factory
		install -m 0400 ${WORKDIR}/cgminer_s9k.conf.factory ${D}${sysconfdir}/bmminer.conf.factory

	else	
		echo "AntMiner ${Miner_TYPE}" > ${WORKDIR}/user_defined_lcd.factory
		install -m 0400 ${WORKDIR}/network.conf.factory ${D}${sysconfdir}/network.conf.factory
		install -m 0400 ${WORKDIR}/bmminer.conf.factory ${D}${sysconfdir}/bmminer.conf.factory
	fi

	install -m 0400 ${WORKDIR}/user_defined_lcd.factory ${D}${sysconfdir}/user_defined_lcd.factory
	install -m 0400 ${WORKDIR}/user_setting.factory ${D}${sysconfdir}/user_setting.factory

	#install -d ${D}${sysconfdir}/config
	#install -d ${D}${sysconfdir}/config/32xPattern
	#install -d ${D}${sysconfdir}/config/minertest64
	cp --preserve=mode -rf ${WORKDIR}/config ${D}${sysconfdir}

	install -d ${D}${base_sbindir}
	install -m 0755 ${WORKDIR}/monitorcg ${D}${base_sbindir}/
	install -m 0755 ${WORKDIR}/miner_lcd.sh ${D}${base_sbindir}/minerlcd
	install -d ${D}${bindir}
	rm -rf ${D}${bindir}/compile_time
	date > ${D}${bindir}/compile_time
	echo "Antminer ${Miner_TYPE}" >> ${D}${bindir}/compile_time
}