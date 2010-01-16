# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion eutils

DESCRIPTION="GtkD is a D binding and OO wrapper of GTK+ and is released on the LGPL license."
HOMEPAGE="http://www.dsource.org/projects/gtkd"

ESVN_REVISION="${PV}"
ESVN_REPO_URI="http://svn.dsource.org/projects/gtkd/trunk"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
	|| ( >=dev-lang/dmd-2.034 >=dev-lang/dmd-1.0.49 )
	>=x11-libs/gtk+-2
	media-libs/mesa
	x11-libs/gtkglext"
RDEPEND="${DEPEND}"

src_unpack() {
	subversion_src_unpack
}


src_compile() {
	emake libs || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" prefix="/usr" install || die "emake install failed"
}
