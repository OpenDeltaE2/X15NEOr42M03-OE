DESCRIPTION = "Edision Kernel"
SECTION = "kernel"
LICENSE = "GPL-2.0-only"

INC_PR = "r0"

DEPENDS += "xz-native bc-native"
DEPENDS:append:aarch64 = " libgcc"
KERNEL_CC:append:aarch64 = " ${TOOLCHAIN_OPTIONS}"
KERNEL_LD:append:aarch64 = " ${TOOLCHAIN_OPTIONS}"

KERNEL_EXTRA_ARGS = "EXTRA_CFLAGS+=-Wno-attribute-alias EXTRA_CFLAGS+=-Wno-address"

# Pick up shared functions
inherit kernel

export OS = "Linux"

S = "${UNPACKDIR}/linux-${PV}"
B = "${UNPACKDIR}/build"

KERNEL_IMAGEDEST = "tmp"

FILES:${KERNEL_PACKAGE_NAME}-image = "${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE}*"

pkg_postinst:kernel-image () {
	if [ -z "$D" ]
	then
		MTD_DEVICE=$(grep 'kernel' /proc/mtd | cut -f1 -d':')
		flash_eraseall /dev/${MTD_DEVICE}
		nandwrite -p /dev/${MTD_DEVICE} /${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE}-${KERNEL_VERSION}
		rm -f /${KERNEL_IMAGEDEST}/${KERNEL_IMAGETYPE}-${KERNEL_VERSION}
	fi
}

pkg_postrm:kernel-image () {
}

do_rm_work() {
}
