SUMMARY = "${MACHINE} partitions files"
SECTION = "base"
PRIORITY = "required"
LICENSE = "CLOSED"
PR = "${SRCDATE}"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit deploy

SRC_URI = "http://downloads.openpli.org/archive/gfutures/${MACHINE}-partitions-${SRCDATE}.zip"

S = "${UNPACKDIR}"

ALLOW_EMPTY:${PN} = "1"
do_configure[nostamp] = "1"

do_deploy() {
    install -d ${DEPLOY_DIR_IMAGE}/hd-partitions-${MACHINE}/${MACHINE}
    install -m 0755 ${UNPACKDIR}/fastboot.bin ${DEPLOY_DIR_IMAGE}/hd-partitions-${MACHINE}
    install -m 0755 ${UNPACKDIR}/${MACHINE}/fastboot.bin ${DEPLOY_DIR_IMAGE}/hd-partitions-${MACHINE}/${MACHINE}
    install -m 0755 ${UNPACKDIR}/${MACHINE}/pq_param.bin ${DEPLOY_DIR_IMAGE}/hd-partitions-${MACHINE}/${MACHINE}
    install -m 0755 ${UNPACKDIR}/${MACHINE}/baseparam.img ${DEPLOY_DIR_IMAGE}/hd-partitions-${MACHINE}/${MACHINE}
    install -m 0755 ${UNPACKDIR}/${MACHINE}/logo.img ${DEPLOY_DIR_IMAGE}/hd-partitions-${MACHINE}/${MACHINE}
    install -m 0755 ${UNPACKDIR}/${MACHINE}/dtbo.img ${DEPLOY_DIR_IMAGE}/hd-partitions-${MACHINE}/${MACHINE}
}

addtask deploy before do_build after do_install

INSANE_SKIP:${PN} += "already-stripped"
