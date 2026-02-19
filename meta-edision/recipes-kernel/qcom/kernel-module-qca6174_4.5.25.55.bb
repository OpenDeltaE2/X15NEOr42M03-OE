DESCRIPTION = "qcacld-2.0 module.bbclass mechanism."
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://Android.mk;md5=235cc8d87e0fb1c956be4af0d07074fb"

inherit module

COMPATIBLE_MACHINE = "osmio4k|osmio4kplus"

SRC_URI = "https://downloads.openpli.org/archive/edision/qcacld-2.0-${PV}.tar.gz \
    file://qcacld-2.0-support.patch \
"

SRC_URI[md5sum] = "639660ec3ead1dc59e4ca20bfce7b4c9"
SRC_URI[sha256sum] = "870b0e762e8ee885938eaf7da9dea0b6505a40a0eae7ce8c6409b53e015faa7a"
S = "${UNPACKDIR}/qcacld-2.0-${PV}"

do_install() {
    install -d ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra
    install -m 0644 ${S}/wlan.ko ${D}${nonarch_base_libdir}/modules/${KERNEL_VERSION}/extra

    install -d -m 0755 ${D}${sysconfdir}/modules-load.d
    echo wlan > ${D}${sysconfdir}/modules-load.d/wlan.conf
}

python do_package:prepend() {
    d.prependVar('PKGV', '-')
    d.prependVar('PKGV', d.getVar("KERNEL_VERSION", True).split("-")[0])
}

FILES:${PN} += "${sysconfdir}/modules-load.d/wlan.conf"
