# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop xdg

DESCRIPTION="An open-world game whose gameplay revolves around breaking and placing blocks"
HOMEPAGE="https://www.minecraft.net/"
SRC_URI="https://launcher.mojang.com/v1/objects/eb4ad36e1c78e57e5ed1550fc35067475a05a521/minecraft-launcher -> minecraft-launcher-1121"

KEYWORDS="amd64"
LICENSE="Mojang"
SLOT="2"

RESTRICT="bindist mirror"

RDEPEND="
	>=x11-libs/gtk+-2.24.32-r1[X]
	dev-libs/nss
	dev-libs/libbsd
	dev-libs/libffi
	dev-libs/libpcre
	media-libs/alsa-lib
	media-libs/openal
	net-libs/gnutls[idn]
	net-print/cups
	sys-apps/dbus
	virtual/jre:1.8
	virtual/opengl
	x11-apps/xrandr
	x11-libs/libXScrnSaver
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/xcb-util
"

S="${WORKDIR}"

QA_PREBUILT="
	/opt/bin/${PN}
"

src_install() {
	dodir /opt
	into /opt
	newbin ${DISTDIR}/${P} ${PN}
	doicon -s scalable "${FILESDIR}/${PN}.svg"
	make_desktop_entry ${PN} "Minecraft" ${PN} Game
}

pkg_postinst() {
	xdg_icon_cache_update
	einfo "This package has installed the Java Minecraft launcher."
	einfo "To actually play the game, you need to purchase an account at:"
	einfo "    ${HOMEPAGE}"
}

pkg_postrm() {
	xdg_icon_cache_update
}