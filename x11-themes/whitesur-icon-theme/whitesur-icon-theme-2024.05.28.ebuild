# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit xdg

DESCRIPTION="A macOS Big Sur-style icon theme for Linux desktops"
HOMEPAGE="https://github.com/vinceliuice/WhiteSur-icon-theme"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV//./-}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
	S="${WORKDIR}/WhiteSur-icon-theme-${PV//./-}"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"

src_install() {
	mkdir -p "${ED}/usr/share/icons"
	./install.sh --dest "${ED}/usr/share/icons" --theme "all" || die
}
