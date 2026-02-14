FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PV = "1.26.10"

SRC_URI[sha256sum] = "fec973dff512b507d9dcb5a828e04e061e52188f4d5989e953aed6a41beda437"

SRC_URI:append = "file://001-rtmp-hls-tsdemux-fix.patch \
                  file://003-rtmp-fix-seeking-and-potential-segfault.patch \
"

PACKAGECONFIG = "${GSTREAMER_ORC} bz2 closedcaption curl dash dtls faac faad hls openssl opusparse \
                 rsvg rtmp sbc smoothstreaming sndfile ttml uvch264 webp \
"
