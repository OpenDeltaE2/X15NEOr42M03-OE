SUMMARY = "Hardware drivers for ${MACHINE}"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"

KV = "4.1.24"
GCCREV = "6.3.0"
SRCDATE = "20170614"

SRC_URI[md5sum] = "208093dad3f4be9a6fa5d1c4d0e46387"
SRC_URI[sha256sum] = "49c3b7d053fa23cd59ce5f38a7c5db9b0e873dcbf39fe5e8ae05600339f4d620"

PV = "${KV}+${SRCDATE}"
PR = "r0"

SRC_URI = "http://downloads.openpli.org/archive/sab/alphatriple-drivers-${KV}-${GCCREV}-${SRCDATE}.zip"

S = "${UNPACKDIR}"

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
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

COMPATIBLE_MACHINE = "alphatriplehd"

