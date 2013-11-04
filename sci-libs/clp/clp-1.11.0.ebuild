# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils flag-o-matic

DESCRIPTION="Clp (Coin-or linear programming) is an open-source linear programming solver written in C++."
HOMEPAGE="https://projects.coin-or.org/Clp"

MY_P=${P/clp/Clp}
SRC_URI="http://www.coin-or.org/download/source/Clp/${MY_P}.tgz"
S=${WORKDIR}/${MY_P}

LICENSE="CPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

src_compile() {
	emake || die "emake failed"

	if use doc; then
		emake doxydoc || die "emake doxydoc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		dohtml doxydoc/html/* || die "dohtml failed"
	fi
}
