DESCRIPTION = "meta file for Oscam EMU with PCSC reader support"

require conf/license/openpli-gplv2.inc

RDEPENDS_${PN} = "enigma2-plugin-softcams-oscam-emu pcsc-lite libpcsclite1"
