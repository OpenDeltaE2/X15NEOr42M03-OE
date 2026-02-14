FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PV = "1.26.10"

SRC_URI[sha256sum] = "7beacb5daba3c6751ebc1c85017d9b1d6de64e24798125932c73c8b1dbeb3bc9"

DEPENDS:append = " libsoup-2.4"
RDEPENDS:${PN}-soup += "libsoup-2.4"

SRC_URI:append = " file://001-gstrtpmp4gpay-set-dafault-value-for-MPEG4-without-co.patch"

PACKAGECONFIG = "${GSTREAMER_ORC} amrnb amrwb bz2 cairo flac gdk-pixbuf gudev jpeg lame libpng \
                 mpg123 soup2 speex taglib v4l2 vpx wavpack \
"
