DESCRIPTION = "Miraclebox HbbTv"
PRIORITY = "optional"
LICENSE = "CLOSED"

PACKAGE_ARCH = "${MACHINE_ARCH}"
RDEPENDS:${PN} += "libjpeg-turbo"

SRC_URI = "file://enigma2-plugin-extensions-hbbtv-miraclebox.tar.gz"

inherit gitpkgv

PR = "r1"

SRCREV = "${AUTOREV}"

FILES:${PN} = "/usr"

INHIBIT_PACKAGE_STRIP = "1"
INSANE_SKIP += "file-rdeps"

ALLOW_EMPTY:${PN} = "1"

S = "${UNPACKDIR}/usr"

do_install() {
	install -d ${D}/usr
	cp -a --no-preserve=ownership ${S}/* ${D}/usr/
}
