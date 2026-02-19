DESCRIPTION = "E2 Chromium Plugin"
SECTION = "base"
PRIORITY = "optional"
LICENSE = "CLOSED"
# require conf/license/license-close.inc

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PV = "1.0"
PR = "20180628_r0"
SRC_URI = "http://downloads.openpli.org/archive/gigablue/e2plugin-chromium-gigablue_${PR}.tar.gz"
SRC_URI:append = " \
           file://port-to-python3-gigablue.patch"

COMPATIBLE_MACHINE = "^(gbquad4kpro|gbquad4k|gbue4k)$"

DEPENDS = "chromium-browser"
RDEPENDS:${PN} = "chromium-browser"

do_install:append() {
    install -d ${D}/usr/lib/enigma2/python/Plugins/Extensions/Chromium
    cp -aRf --no-preserve=ownership ${UNPACKDIR}/e2plugin/* ${D}/usr/lib/enigma2/python/Plugins/Extensions/Chromium/
}

do_package_qa() {
}

PROVIDES += "enigma2-plugin-extensions-chromium"
RPROVIDES:${PN} += "enigma2-plugin-extensions-chromium"

FILES:${PN} = "/"

SRC_URI[md5sum] = "6b1db0620fd187252d1195a4389da930"
SRC_URI[sha256sum] = "9723574753390358d567bcfeb364485f26d279417436c927f0534d27c24f9779"

