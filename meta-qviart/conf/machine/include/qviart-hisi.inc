# We know about rtc
MACHINE_FEATURES_BACKFILL_CONSIDERED = "rtc"

APPLOADER_FILE = "apploader.bin"

MACHINE_ESSENTIAL_EXTRA_RDEPENDS += " \
	qviart-reader-${SOC_FAMILY} \
	qviart-libreader-${SOC_FAMILY} \
	qviart-loadmodules-${SOC_FAMILY} \
	qviart-opengl-${SOC_FAMILY} \
	qviart-bootoptions-${MACHINE} \
	partitions-by-name \
	e2fsprogs-resize2fs \
	qviart-libs-${SOC_FAMILY} \
	kernel-module-8192eu \
	deepsleep-${SOC_FAMILY} \
	${SOC_FAMILY}-shutdown \
	qviart-dvb-modules-${MACHINE} \
	${@bb.utils.contains('MACHINE_FEATURES', 'fastboot', 'android-tools', '', d)} \
	${@bb.utils.contains('MACHINE_FEATURES', 'emmc', 'partitions-by-name', '', d)} \
	qviart-blindscan-utils-${SOC_FAMILY} \
	qviart-partitions-${MACHINE} \
	qviart-buildimage \
"


IMAGE_CLASSES += "qviart-emmc_image"
IMAGE_FSTYPES += "qviartemmc"
IMAGE_ROOTFS_SIZE ?= "524288"

TARGET_ARCH = "arm"
DEFAULTTUNE = "cortexa15hf-neon-vfpv4"

PREFERRED_PROVIDER_virtual/kernel = "linux-qviart"

PREFERRED_PROVIDER_virtual/egl = "qviart-opengl-${SOC_FAMILY}"
PREFERRED_PROVIDER_virtual/libgles1 = "qviart-opengl-${SOC_FAMILY}"
PREFERRED_PROVIDER_virtual/libgles2 = "qviart-opengl-${SOC_FAMILY}"
PREFERRED_PROVIDER_virtual/kodi = "stb-kodi-${SOC_FAMILY}"
PREFERRED_RPROVIDER_aio-grab = "qviart-grab-${SOC_FAMILY}"

PREFERRED_PROVIDER_virtual/blindscan-dvbs = "qviart-blindscan-utils-${SOC_FAMILY}"

MACHINE_FEATURES += " alsa usbhost wlan switchoff osdposition hdmicec"

DVBMEDIASINK_CONFIG = "--with-pcm --with-eac3 --with-amr --with-wmv --with-h265 --with-vb8 --with-vb9 --with-spark --with-dts"

require conf/machine/include/arm/armv7a/tune-cortexa15.inc

MACHINE_EXTRA_RRECOMMENDS = " \
	ffmpeg \
	ntfs-3g \
"

IMAGEDIR ?= "${MACHINE}"
IMGDEPLOYDIR ?= "${DEPLOY_DIR_IMAGE}"
IMAGEVERSION := "${DISTRO_NAME}-${DISTRO_VERSION}-${DATE}"
IMAGEVERSION[vardepsexclude] = "DATE"

IMAGE_CMD:qviartemmc:append = "\
    mkdir -p ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}; \
    mkdir -p ${DEPLOY_DIR_IMAGE}/release/${IMAGEDIR}; \
    cp ${DEPLOY_DIR_IMAGE}/uImage ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}/${KERNEL_FILE}; \
    cp ${DEPLOY_DIR_IMAGE}/${APPLOADER_FILE} ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}/${APPLOADER_FILE}; \
    mv ${IMGDEPLOYDIR}/${IMAGE_NAME}_subrootfs.ext4 ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}/rootfs.ext4; \
    cd ${DEPLOY_DIR_IMAGE}; \
    zip ${DISTRO_NAME}-${DISTRO_VERSION}-${MACHINE}_usb.zip ${IMAGEDIR}/*; \
    cd ${IMAGE_ROOTFS}; \
    tar -cvf ${DEPLOY_DIR_IMAGE}/rootfs.tar -C ${IMAGE_ROOTFS} .; \
    mv ${DEPLOY_DIR_IMAGE}/rootfs.tar ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}/rootfs.tar; \
    cd ${DEPLOY_DIR_IMAGE}; \
    bzip2 ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}/rootfs.tar; \
    echo ${IMAGEVERSION} > ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}/imageversion; \
    zip -j ${DISTRO_NAME}-${DISTRO_VERSION}-${MACHINE}_multiboot_ofgwrite.zip ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}/imageversion ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}/kernel.bin ${DEPLOY_DIR_IMAGE}/${IMAGEDIR}/rootfs.tar.bz2; \
    rm -f ${DEPLOY_DIR_IMAGE}/*.manifest; \
    rm -Rf ${DEPLOY_DIR_IMAGE}/rootfs; \
    rm -f ${DEPLOY_DIR_IMAGE}/.ext4; \
    rm -f ${DEPLOY_DIR_IMAGE}/.manifest; \
    rm -f -f ${DEPLOY_DIR_IMAGE}/*.json; \
    rm -Rf ${IMAGEDIR}; \
    rm -Rf release; \
    "

BBMASK = "meta-openpli/recipes-support/partitions-by-name"
BBMASK = "meta-vuplus/recipes-graphics/"
BBMASK = "meta-vuplus/recipes-webkit/"
BBMASK = "meta-openpli/recipes-webkit/"

