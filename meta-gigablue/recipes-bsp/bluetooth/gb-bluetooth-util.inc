SECTION = "base"
LICENSE = "CLOSED"
# require conf/license/license-close.inc

PROVIDES += "gb-bluetooth-util"
RPROVIDES:${PN} += "gb-bluetooth-util"

PR = "${SRCDATE}.${SRCDATE_PR}"

SRC_URI = " \
    http://downloads.openpli.org/archive/gigablue/gb-bluetooth-util-gb7252-${PR}.tar.gz \
"

S = "${UNPACKDIR}/gb-bluetooth-util-gb7252"

do_package_qa() {
}

PACKAGE_ARCH = "${MACHINE_ARCH}"
FILES:${PN} = "/"

do_install() {
	install -d ${D}/usr/local/bin
	install -m 0755 ${S}/bsa_server ${D}/usr/local/bin/

	install -d ${D}/usr/local/lib
	install -d ${D}/usr/local/lib/modules
	install -m 0644 ${S}/btusb.ko ${D}/usr/local/lib/modules/btusb.ko
	install -m 0644 ${S}/bthid.ko ${D}/usr/local/lib/modules/bthid.ko
}

INSANE_SKIP:${PN} = "already-stripped"
