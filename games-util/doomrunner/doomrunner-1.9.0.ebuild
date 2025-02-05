# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="Preset-oriented graphical launcher of various ported Doom engines (an alternative to ZDL)"
HOMEPAGE="https://github.com/Youda008/DoomRunner"
SRC_URI="https://github.com/Youda008/DoomRunner/tarball/7462b33021250a1507c41fdda7a411f2667171b1 -> DoomRunner-1.9.0-7462b33.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtnetwork:5"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/cmake"

S="${WORKDIR}/Youda008-DoomRunner-7462b33"


src_prepare() {
	default
	eapply_user
}

src_configure() {
	eqmake5 DoomRunner.pro -spec linux-g++ CONFIG+="release"  PREFIX="/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

# vim: ts=4 noet syn=ebuild