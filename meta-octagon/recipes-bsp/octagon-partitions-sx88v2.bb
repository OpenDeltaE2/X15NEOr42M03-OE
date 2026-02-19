SUMMARY = "SX88V2 partitions files"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit deploy

SRCDATE = "20221216"
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
    install -m 0755 ${S}/emmc_partitions.xml ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/baseparam.img ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${UNPACKDIR}/logo.img ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/deviceinfo.bin ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
    install -m 0755 ${S}/6605s.upg ${DEPLOY_DIR_IMAGE}/${MACHINE}-partitions
}

addtask deploy before do_build after do_install

SRC_URI[md5sum] = "15ac1bb9edeb76d68f2173f49baa7f70"
SRC_URI[sha256sum] = "01b324aa5a4a9125387b974622d4b4db3c4e124b4f6c4aaff404a574be15fd17"

INSANE_SKIP:${PN} += "already-stripped"
