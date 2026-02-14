FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

RDEPENDS:libgstgl-1.0 = "libGLESv2.so"

PV = "1.26.10"

SRC_URI[sha256sum] = "1c1531dd8f2d480c89c57b08a930545a3375077391789762e40e490cdbbf03fd"

SRC_URI:append = " file://001-riff-media-added-fourcc-to-all-ffmpeg-mpeg4-video-caps.patch \
                   file://002-subparse-avoid-false-negatives-dealing-with-UTF-8.patch \
                   file://define-surfaceless-mesa-macro.patch \
"

PACKAGECONFIG = "${GSTREAMER_ORC} alsa jpeg ogg opus pango png theora vorbis"
