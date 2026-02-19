SUMMARY = "SF8008 Mini partitions files"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit deploy

SRCDATE = "20201218"
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

SRC_URI[md5sum] = "691efd35fa5c1661ad82a3a7cd09281e"
SRC_URI[sha256sum] = "77f85262523b8f7003f935a8a757d194687b5c2be205bd5b4674eba3af3f2e01"

INSANE_SKIP:${PN} += "already-stripped"
