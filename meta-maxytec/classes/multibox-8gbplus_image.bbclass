inherit image_types

IMAGE_TYPEDEP:multibox8gbplus = "ext4 tar"
BOOTOPTIONS_PARTITION_SIZE = "2048"

do_image_multibox8gbplus[depends] = " \
	e2fsprogs-native:do_populate_sysroot \
	android-tools-native:do_populate_sysroot \
	dosfstools-native:do_populate_sysroot \
	mtools-native:do_populate_sysroot \
	"

IMAGE_CMD:multibox8gbplus () {
    dd if=/dev/zero of=${UNPACKDIR}/bootoptions.img bs=1024 count=${BOOTOPTIONS_PARTITION_SIZE}
    mkfs.msdos -S 512 ${UNPACKDIR}/bootoptions.img
    echo "bootcmd=setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3BD000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP
    echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs1 rootfstype=ext4 kernel=/dev/mmcblk0p19" >> ${UNPACKDIR}/STARTUP
    echo "bootcmd=setenv bootargs \$(bootargs) \$(bootargs_common); run bootcmd_android; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_ANDROID
    echo "bootargs=androidboot.selinux=disabled" >> ${UNPACKDIR}/STARTUP_ANDROID
    echo "bootcmd=setenv bootargs \$(bootargs) \$(bootargs_common); run bootcmd_android; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_ANDROID_DISABLE_LINUXSE
    echo "bootargs=androidboot.selinux=disabled" >> ${UNPACKDIR}/STARTUP_ANDROID_DISABLE_LINUXSE
    echo "bootcmd=setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3BD000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_LINUX_1
    echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs1 rootfstype=ext4 kernel=/dev/mmcblk0p19" >> ${UNPACKDIR}/STARTUP_LINUX_1
    echo "bootcmd=setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3C5000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_LINUX_2
    echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs2 rootfstype=ext4 kernel=/dev/mmcblk0p20" >> ${UNPACKDIR}/STARTUP_LINUX_2
    echo "bootcmd=setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3CD000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_LINUX_3
    echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs3 rootfstype=ext4 kernel=/dev/mmcblk0p21" >> ${UNPACKDIR}/STARTUP_LINUX_3
    echo "bootcmd=setenv bootargs \$(bootargs) \$(bootargs_common); mmc read 0 0x1000000 0x3D5000 0x8000; bootm 0x1000000; run bootcmd_fallback" > ${UNPACKDIR}/STARTUP_LINUX_4
    echo "bootargs=root=/dev/mmcblk0p23 rootsubdir=linuxrootfs4 rootfstype=ext4 kernel=/dev/mmcblk0p22" >> ${UNPACKDIR}/STARTUP_LINUX_4
    echo "bootcmd=setenv bootargs \$(bootargs_common); mmc read 0 0x1000000 0x1000 0x9000; bootm 0x1000000" > ${UNPACKDIR}/STARTUP_RECOVERY
    echo "imageurl https://raw.githubusercontent.com/oe-alliance/bootmenu/master/${MACHINE}/images" > ${UNPACKDIR}/bootmenu.conf
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
}
