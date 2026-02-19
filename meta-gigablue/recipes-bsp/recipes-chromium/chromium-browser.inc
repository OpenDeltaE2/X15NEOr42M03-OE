SUMMARY = "Chromium and YoutubeTV"
SECTION = "base"
PRIORITY = "optional"
LICENSE = "CLOSED"
# require conf/license/license-close.inc
PACKAGE_ARCH = "${MACHINE_ARCH}"

PV = "1.0"
PR = "${SRCDATE}"
SRC_URI = "http://downloads.openpli.org/archive/gigablue/chromium-gigablue-gb7252-${SRCDATE}.zip"

# Added very old NSS version need only for vuplus
PREFERRED_VERSION_nss = "3.17.3"

DEPENDS = "nss"
RDEPENDS:${PN} = "nspr nss libxslt libcurl libudev"
RDEPENDS:${PN} += "gb-v3ddriver-${MACHINE_DRIVER}"

do_install() {
	install -d ${D}/usr/local/chromium
	cp -afR --no-preserve=ownership ${UNPACKDIR}/chromium/* ${D}/usr/local/chromium/
	chmod 755 ${D}/usr/local/chromium/run.sh
	chmod 755 ${D}/usr/local/chromium/bin/browser_shell
	chmod 755 ${D}/usr/local/chromium/bin/chrome
	chmod 755 ${D}/usr/local/chromium/bin/chrome-sandbox
	chmod 755 ${D}/usr/local/chromium/bin/nxconfig
	install -d ${D}/usr/local/lib
	ln -s /usr/lib/libv3ddriver.so ${D}/usr/local/lib/libv3ddriver.so
}

do_package_qa() {
}

PROVIDES += "virtual/chromium-browser"
RPROVIDES:${PN} += "virtual-chromium-browser"
PROVIDES += "chromium-browser"
RPROVIDES:${PN} += "chromium-browser"

FILES:${PN} = "/"

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
INSANE_SKIP:${PN} += "already-stripped"
