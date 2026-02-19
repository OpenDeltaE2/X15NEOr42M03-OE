SUMMARY = "SFX6008 partitions files"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit deploy

SRCDATE = "20221026"
PR = "${SRCDATE}"

S = "${UNPACKDIR}/partitions"

SRC_URI = "\
	http://downloads.openpli.org/archive/octagon/${MACHINE}-partitions-${SRCDATE}.zip \
	file://logo.img \
	"

ALLOW_EMPTY:${PN} = "1"
do_configure[nostamp] = "1"
do_install[noexec] = "1"

do_deploy() {
    install -d ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/bootargs.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/boot.img ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/fastboot.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/apploader.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/pq_param.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/nand_partitions.xml ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/baseparam.img ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${UNPACKDIR}/logo.img ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/deviceinfo.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
}

addtask deploy before do_build after do_install

SRC_URI[md5sum] = "285a7b955795db825f8338707e3bee35"
SRC_URI[sha256sum] = "562d8be97f748388850b733b76002787087ac0c8a153d7b877e84c8a91e7100f"

INSANE_SKIP:${PN} += "already-stripped"
