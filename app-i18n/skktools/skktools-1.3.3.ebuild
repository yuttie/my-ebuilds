# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Utility programs for SKK dictionaries that are written in C"
HOMEPAGE="http://openlab.ring.gr.jp/skk/wiki/wiki.cgi?page=%BC%AD%BD%F1%A5%E1%A5%F3%A5%C6%A5%CA%A5%F3%A5%B9%A5%C4%A1%BC%A5%EB"
SRC_URI="http://openlab.ring.gr.jp/skk/tools/${P}.tar.gz"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+skkdic-expr2 gdbm"
DEPEND="skkdic-expr2? ( >=dev-libs/glib-2.0.0 )
	gdbm? ( sys-libs/gdbm )
	!gdbm? ( || ( sys-libs/db sys-libs/gdbm ) )"
RDEPEND="${DEPEND}"
DOCS="ChangeLog README READMEs/FAQ.txt READMEs/README.C READMEs/README.skkdic-expr2"

src_configure() {
	econf \
		$(use_with skkdic-expr2) \
		$(use_with gdbm) || die
}
