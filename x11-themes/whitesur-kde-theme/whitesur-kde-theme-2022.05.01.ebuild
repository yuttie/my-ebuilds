# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A macOS Big Sur theme for KDE Plasma"
HOMEPAGE="https://github.com/vinceliuice/WhiteSur-kde"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV//./-}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
	S="${WORKDIR}/WhiteSur-kde-${PV//./-}"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"

RDEPEND="x11-themes/kvantum"

src_prepare() {
	eapply_user

	sed -i -e 's|/usr/share|${DESTDIR}/usr/share|' ./install.sh || die "Sed failed!"
}

src_install() {
	export DESTDIR="${ED}"
	./install.sh || die
}
