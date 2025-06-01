# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="(T)he k(I)cki(N) (T)ickin d(I)kumud clie(N)t"
HOMEPAGE="https://tintin.mudhalla.net"
SRC_URI="https://github.com/scandum/tintin/tarball/834bcfa80a2cba3b41087d19dbc9e5fb78ab51bf -> tintin-2.02.51-834bcfa.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="*"

DEPEND="
	dev-libs/libpcre
	net-libs/gnutls
	sys-libs/readline:0
	sys-libs/zlib"
RDEPEND=${DEPEND}

#S=${WORKDIR}/tt/src
S="${WORKDIR}/scandum-tintin-834bcfa/src"

src_install() {
	dobin tt++
	dodoc ../{CREDITS,FAQ,README,SCRIPTS,TODO,docs/*}
}

pkg_postinst() {
	ewarn "**** OLD TINTIN SCRIPTS ARE NOT 100% COMPATIBLE WITH THIS VERSION ****"
	ewarn "read the README for more details."
}
# vim: noet ts=4 syn=ebuild