inherit image_types

do_image_zgemmayaffs[depends] = " \
	e2fsprogs-native:do_populate_sysroot \
	dosfstools-native:do_populate_sysroot \
	mtools-native:do_populate_sysroot \
	mkyaffs2utils-native:do_populate_sysroot \
"

IMAGE_CMD:zgemmayaffs () {
	mkdir -p ${UNPACKDIR}/bootoptions
	echo "imageurl https://raw.githubusercontent.com/oe-alliance/bootmenu/master/${MACHINE}/images" > ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "# " >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "iface eth0" >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "dhcp yes" >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "# " >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "# for static config leave out 'dhcp yes' and add the following settings:" >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "# " >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "#ip 192.168.1.10" >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "#netmask 255.255.255.0" >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "#gateway 192.168.1.1" >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	echo "#dns 192.168.1.1" >> ${UNPACKDIR}/bootoptions/bootmenu.conf
	mkyaffs ${UNPACKDIR}/bootoptions/ ${UNPACKDIR}/bootoptions.yaffs 4k -b=750
	cp ${UNPACKDIR}/bootoptions.yaffs ${IMGDEPLOYDIR}/bootoptions.yaffs
}
