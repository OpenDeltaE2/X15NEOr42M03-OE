KV = "4.1.21"
SRCDATE = "20170424"
GCC = "6.3.0"

SUMMARY = "Hardware drivers for ${MACHINE}"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"

PV = "${KV}+${SRCDATE}"
PR = "r0"

SRC_URI = "http://downloads.openpli.org/archive/xpeedc/${MACHINE}-drivers-${KV}-${GCC}-${SRCDATE}.zip"

SRC_URI[md5sum] = "036d57fc2083cc4c5c0fb4046d45da52"
SRC_URI[sha256sum] = "b54e83363ee5c03b18cc7c4a13bbe1d9b49c07835f1866c91a2ff31b5416c2e6"

S = "${UNPACKDIR}"

INHIBIT_PACKAGE_STRIP = "1"

inherit module

do_compile() {
}

do_install() {
    install -d ${D}/lib/modules/${KV}/extra
    install -d ${D}/${sysconfdir}/modules-load.d
    for i in tpm modloader modloader2 dvb; do
        install -m 0755 ${UNPACKDIR}/$i.ko ${D}/lib/modules/${KV}/extra
        echo $i >> ${D}/${sysconfdir}/modules-load.d/_${MACHINE}.conf
    done
}

FILES:${PN} += "${sysconfdir}/modules-load.d/_${MACHINE}.conf"

COMPATIBLE_MACHINE = "xpeedc"
