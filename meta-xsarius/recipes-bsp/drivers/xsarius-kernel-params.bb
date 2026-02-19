DESCRIPTION = "Deault sysctl value"
SECTION = "base"
PRIORITY = "required"
PACKAGE_ARCH = "${MACHINE_ARCH}"

require conf/license/openpli-gplv2.inc

S = "${UNPACKDIR}"

SRC_URI = " \
	file://kernel-params.sh \
"

inherit deploy

do_install() {
	install -d ${D}${sysconfdir}/rcS.d
	install -d ${D}${sysconfdir}/init.d
	install -m 0655 ${UNPACKDIR}/kernel-params.sh ${D}${sysconfdir}/init.d

	ln -sf  ../init.d/kernel-params.sh ${D}${sysconfdir}/rcS.d/S06kernel-params.sh
}
