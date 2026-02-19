DESCRIPTION = "Hardware drivers for ${MACHINE}"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"

PV = "${KV}+${SRCDATE}"
PR = "r0"

SRC_URI = "https://downloads.openpli.org/archive/amiko/${MACHINE}-drivers-${KV}-${SRCDATE}.zip"

S = "${UNPACKDIR}"

INHIBIT_PACKAGE_STRIP = "1"

inherit module

FILES:${PN} += "${sysconfdir}/modules-load.d/_${MACHINE}.conf"

do_compile() {
}

do_install() {
	install -d ${D}/lib/modules/${KV}/extra
	install -d ${D}/${sysconfdir}/modules-load.d
    install -m 0755 ${UNPACKDIR}/dvb.ko ${D}/lib/modules/${KV}/extra
    echo dvb >> ${D}/${sysconfdir}/modules-load.d/_${MACHINE}.conf
}
