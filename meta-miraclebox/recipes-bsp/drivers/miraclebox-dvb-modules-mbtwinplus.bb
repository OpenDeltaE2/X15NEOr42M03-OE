SUMMARY = "Hardware drivers for ${MACHINE}"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"

KV = "4.1.24"
GCCREV = "6.3.0"
SRCDATE = "20170614"

SRC_URI[md5sum] = "0192a1f3f6b50600e523678e41fc6d80"
SRC_URI[sha256sum] = "a965c6f2d8c8c766d872654dde0ef39d290a7c2c91c98f0faa44ae69d1e984db"

PV = "${KV}+${SRCDATE}"
PR = "r0"

SRC_URI = "http://downloads.openpli.org/archive/miraclebox/twinplus-drivers-${KV}-${GCCREV}-${SRCDATE}.zip"

S = "${UNPACKDIR}"

INHIBIT_PACKAGE_STRIP = "1"

inherit module

do_compile() {
}
do_populate_sysroot() {
}

do_install() {
    install -d ${D}/lib/modules/${KV}/extra
    install -d ${D}/${sysconfdir}/modules-load.d
    install -m 0755 ${UNPACKDIR}/linuxtv.ko ${D}/lib/modules/${KV}/extra
    echo linuxtv >> ${D}/${sysconfdir}/modules-load.d/_${MACHINE}.conf
}

FILES:${PN} += "${sysconfdir}/modules-load.d/_${MACHINE}.conf"

