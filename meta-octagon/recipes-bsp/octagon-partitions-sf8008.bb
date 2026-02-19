SUMMARY = "SF8008 partitions files"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit deploy

SRCDATE = "20240104"
PR = "${SRCDATE}"

S = "${UNPACKDIR}/patitions"

SRC_URI = "\
	http://downloads.openpli.org/archive/octagon/${MACHINE}-partitions-${SRCDATE}.zip \
	file://logo.img \
	"

ALLOW_EMPTY:${PN} = "1"
do_configure[nostamp] = "1"
do_install[noexec] = "1"

FILES:${PN} = "/usr/share"

do_deploy() {
    install -d ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/bootargs.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/boot.img ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/fastboot.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/apploader.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/pq_param.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/emmc_partitions.xml ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/baseparam.img ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${UNPACKDIR}/logo.img ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/deviceinfo.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
}

addtask deploy before do_build after do_install

SRC_URI[md5sum] = "9571fcd6d6fc9ab0c4352652cf3b91a1"
SRC_URI[sha256sum] = "a84766e50fd9cc1048520e13d73ba0fc16dff1d4ac65c127cc2e71d48d71791d"

INSANE_SKIP:${PN} += "already-stripped"
