EXTRA_OECONF = " \
    ${@bb.utils.contains('PACKAGECONFIG', 'static', '--with-static-compiler=\"${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS}\"', '', d)} \
"
