# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils desktop xdg-utils

MY_P="SuperTuxKart-${PV}-src"
DESCRIPTION="A kart racing game starring Tux, the linux penguin (TuxKart fork)"
HOMEPAGE="https://supertuxkart.net/"
SRC_URI="https://github.com/supertuxkart/stk-code/releases/download/1.3/SuperTuxKart-1.3-src.tar.xz"

LICENSE="GPL-2 GPL-3 CC-BY-SA-3.0 CC-BY-SA-4.0 CC0-1.0 public-domain ZLIB"
SLOT="0"
KEYWORDS="*"
IUSE="debug libressl nettle recorder sqlite wiimote"

# don't unbundle irrlicht and bullet
# both are modified and system versions will break the game
# https://sourceforge.net/p/irrlicht/feature-requests/138/

RDEPEND="
	dev-cpp/libmcpp
	sqlite? ( dev-db/sqlite:3 )
	dev-libs/angelscript:=
	media-libs/freetype:2
	media-libs/glew:0=
	media-libs/harfbuzz:=
	media-libs/libpng:0=
	media-libs/libsdl2
	media-libs/libvorbis
	media-libs/openal
	net-libs/enet:1.3=
	net-misc/curl
	sys-libs/zlib
	virtual/glu
	virtual/jpeg:0
	virtual/libintl
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXxf86vm
	nettle? ( dev-libs/nettle:= )
	!nettle? (
		libressl? ( dev-libs/libressl:= )
		!libressl? ( >=dev-libs/openssl-1.0.1d:0= )
	)
	recorder? ( media-libs/libopenglrecorder )
	wiimote? ( net-wireless/bluez )"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${PN}-1.1-irrlicht-arch-support.patch
)

src_prepare() {
	cmake-utils_src_prepare

	# Use system glext for irrlicht
	find lib/irrlicht/source/Irrlicht \
		-type f \
		-exec sed -i \
			-e 's|"glext\.h"|<GL\/glext\.h>|g' \
			-e 's|"glxext\.h"|<GL\/glxext\.h>|g' \
			{} \;
}

src_configure() {
	local mycmakeargs=(
		-DUSE_SQLITE3=$(usex sqlite)
		-DUSE_SYSTEM_ANGELSCRIPT=ON
		-DUSE_SYSTEM_ENET=ON
		-DUSE_SYSTEM_GLEW=ON
		-DUSE_SYSTEM_SQUISH=OFF
		-DUSE_SYSTEM_WIIUSE=OFF
		-DUSE_IPV6=OFF # not supported by system enet
		-DOpenGL_GL_PREFERENCE=GLVND
		-DUSE_CRYPTO_OPENSSL=$(usex nettle no yes)
		-DBUILD_RECORDER=$(usex recorder)
		-DUSE_WIIUSE=$(usex wiimote)
		-DSTK_INSTALL_BINARY_DIR=bin
		-DSTK_INSTALL_DATA_DIR=share/${PN}
		-DBUILD_SHARED_LIBS=OFF # build bundled libsquish as static library
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc CHANGELOG.md

	doicon -s 64 "${FILESDIR}"/${PN}.png
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}