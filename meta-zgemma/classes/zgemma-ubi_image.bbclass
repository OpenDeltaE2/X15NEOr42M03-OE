inherit image_types

BOOTOPTIONS_PARTITION_SIZE = "2048"

do_image_zgemmaubi[depends] = " \
	e2fsprogs-native:do_populate_sysroot \
	dosfstools-native:do_populate_sysroot \
	mtools-native:do_populate_sysroot \
"

IMAGE_CMD:zgemmaubi () {
	dd if=/dev/zero of=${UNPACKDIR}/bootoptions.img bs=1024 count=${BOOTOPTIONS_PARTITION_SIZE}
	mkfs.msdos -S 512 ${UNPACKDIR}/bootoptions.img
	echo "bootcmd=nand read 0x1FFFFC0 0x2000000 0x800000;bootm 0x1FFFFC0" >> ${UNPACKDIR}/STARTUP
	echo "bootcmd=nand read 0x1FFFFC0 0x2000000 0x800000;bootm 0x1FFFFC0" >> ${UNPACKDIR}/STARTUP_LINUX_1
	echo "bootcmd=nand read 0x1FFFFC0 0x800000 0x800000;bootm 0x1FFFFC0" > ${UNPACKDIR}/STARTUP_RECOVERY
	echo "imageurl https://raw.githubusercontent.com/oe-alliance/bootmenu/raw/master/${MACHINE}/images" > ${UNPACKDIR}/bootmenu.conf
	echo "# " >> ${UNPACKDIR}/bootmenu.conf
	echo "iface eth0" >> ${UNPACKDIR}/bootmenu.conf
	echo "dhcp yes" >> ${UNPACKDIR}/bootmenu.conf
	echo "# " >> ${UNPACKDIR}/bootmenu.conf
	echo "# for static config leave out 'dhcp yes' and add the following settings:" >> ${UNPACKDIR}/bootmenu.conf
	echo "# " >> ${UNPACKDIR}/bootmenu.conf
	echo "#ip 192.168.1.10" >> ${UNPACKDIR}/bootmenu.conf
	echo "#netmask 255.255.255.0" >> ${UNPACKDIR}/bootmenu.conf
	echo "#gateway 192.168.1.1" >> ${UNPACKDIR}/bootmenu.conf
	echo "#dns 192.168.1.1" >> ${UNPACKDIR}/bootmenu.conf
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP_LINUX_1 ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP_RECOVERY ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/bootmenu.conf ::
	cp ${UNPACKDIR}/bootoptions.img ${IMGDEPLOYDIR}/bootoptions.img
}
