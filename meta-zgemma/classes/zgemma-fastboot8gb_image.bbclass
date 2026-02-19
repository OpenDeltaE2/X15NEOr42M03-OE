inherit image_types

IMAGE_ROOTFS = "${UNPACKDIR}/rootfs/linuxrootfs1"
BOOTOPTIONS_PARTITION_SIZE = "2048"
IMAGE_ROOTFS_SIZE = "614400"

do_image_zgemmafastboot8gb[depends] = " \
	e2fsprogs-native:do_populate_sysroot \
	android-tools-native:do_populate_sysroot \
	dosfstools-native:do_populate_sysroot \
	mtools-native:do_populate_sysroot \
	"

IMAGE_CMD:zgemmafastboot8gb () {
	eval local COUNT=\"0\"
	eval local MIN_COUNT=\"60\"
	if [ $ROOTFS_SIZE -lt $MIN_COUNT ]; then
		eval COUNT=\"$MIN_COUNT\"
	fi
	dd if=/dev/zero of=${IMGDEPLOYDIR}/${IMAGE_NAME}.ext4 seek=$ROOTFS_SIZE count=$COUNT bs=1024
	mkfs.ext4 -F ${IMGDEPLOYDIR}/${IMAGE_NAME}.ext4 -d ${UNPACKDIR}/rootfs
	dd if=/dev/zero of=${UNPACKDIR}/bootoptions.img bs=1024 count=${BOOTOPTIONS_PARTITION_SIZE}
	mkfs.msdos -S 512 ${UNPACKDIR}/bootoptions.img
	echo "bootcmd=setenv notee y; setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3BD000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP
	echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs1 rootfstype=ext4 kernel=/dev/mmcblk0p19" >> ${UNPACKDIR}/STARTUP
	echo "bootcmd=setenv vfd_msg andr;setenv bootargs \$(bootargs) \$(bootargs_common); run bootcmd_android; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_ANDROID
	echo "bootargs=androidboot.hardware=bigfish androidboot.serialno=0123456789 androidboot.selinux=enforcing hbcomp=/dev/block/mmcblk0p13 root=/dev/mmcblk0p13 androidboot.dtbo_idx=0 init=/init skip_initramfs" >> ${UNPACKDIR}/STARTUP_ANDROID
	echo "bootcmd=setenv vfd_msg andr;setenv bootargs \$(bootargs) \$(bootargs_common); run bootcmd_android; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_ANDROID_DISABLE_LINUXSE
	echo "bootargs=androidboot.hardware=bigfish androidboot.serialno=0123456789 androidboot.selinux=disable hbcomp=/dev/block/mmcblk0p13 root=/dev/mmcblk0p13 androidboot.dtbo_idx=0 init=/init skip_initramfs" >> ${UNPACKDIR}/STARTUP_ANDROID_DISABLE_LINUXSE
	echo "bootcmd=setenv notee y; setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3BD000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_LINUX_1
	echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs1 rootfstype=ext4 kernel=/dev/mmcblk0p19" >> ${UNPACKDIR}/STARTUP_LINUX_1
	echo "bootcmd=setenv notee y; setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3C5000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_LINUX_2
	echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs2 rootfstype=ext4 kernel=/dev/mmcblk0p20" >> ${UNPACKDIR}/STARTUP_LINUX_2
	echo "bootcmd=setenv notee y; setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3CD000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_LINUX_3
	echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs3 rootfstype=ext4 kernel=/dev/mmcblk0p21" >> ${UNPACKDIR}/STARTUP_LINUX_3
	echo "bootcmd=setenv notee y; setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3D5000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_LINUX_4
	echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs4 rootfstype=ext4 kernel=/dev/mmcblk0p22" >> ${UNPACKDIR}/STARTUP_LINUX_4
	echo "bootcmd=setenv notee y; setenv bootargs \$(bootargs_common); mmc read 0 0x1000000 0x1000 0x9000; bootm 0x1000000" > ${UNPACKDIR}/STARTUP_RECOVERY
	echo "imageurl https://raw.githubusercontent.com/oe-alliance/bootmenu/master/${MACHINE}/images" > ${UNPACKDIR}/bootmenu.conf
	echo "updateurl http://updateurl.redirectme.net/cgi-bin/index.py" >> ${UNPACKDIR}/bootmenu.conf
	echo "# " >> ${UNPACKDIR}/bootmenu.conf
	echo "iface eth0" >> ${v}/bootmenu.conf
	echo "dhcp yes" >> ${UNPACKDIR}/bootmenu.conf
	echo "# " >> ${UNPACKDIR}/bootmenu.conf
	echo "# for static config leave out 'dhcp yes' and add the following settings:" >> ${UNPACKDIR}/bootmenu.conf
	echo "# " >> ${UNPACKDIR}/bootmenu.conf
	echo "#ip 192.168.1.10" >> ${UNPACKDIR}/bootmenu.conf
	echo "#netmask 255.255.255.0" >> ${UNPACKDIR}/bootmenu.conf
	echo "#gateway 192.168.1.1" >> ${UNPACKDIR}/bootmenu.conf
	echo "#dns 192.168.1.1" >> ${UNPACKDIR}/bootmenu.conf
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP_ANDROID ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP_ANDROID_DISABLE_LINUXSE ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP_LINUX_1 ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP_LINUX_2 ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP_LINUX_3 ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP_LINUX_4 ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/STARTUP_RECOVERY ::
	mcopy -i ${UNPACKDIR}/bootoptions.img -v ${UNPACKDIR}/bootmenu.conf ::
	cp ${UNPACKDIR}/bootoptions.img ${IMGDEPLOYDIR}/bootoptions.img
	echo boot-recovery > ${UNPACKDIR}/misc-boot.img
	cp ${UNPACKDIR}/misc-boot.img ${IMGDEPLOYDIR}/misc-boot.img
	ext2simg ${IMGDEPLOYDIR}/${IMAGE_NAME}.ext4 ${IMGDEPLOYDIR}/${IMAGE_NAME}.userdata.ext4
}
