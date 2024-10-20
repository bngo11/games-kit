# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A 32-level game designed for competitive deathmatch play."
HOMEPAGE="https://freedoom.github.io"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	~games-fps/freedm-data-${PV}
	|| (
		games-fps/gzdoom
		games-engines/odamex
		games-fps/doomsday
	)
"

pkg_postinst() {
	elog "If you are looking for a single-player focused game, please install games-fps/freedoom."
}
