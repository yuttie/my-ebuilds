# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Yet Another Japanese Dependency Structure Analyzer"
HOMEPAGE="https://taku910.github.io/cabocha/"
SRC_URI="http://cabocha.googlecode.com/files/${P}.tar.bz2"

LICENSE="|| ( LGPL-2.1 BSD )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=app-text/crf++-0.58
        app-text/mecab"
RDEPEND="${DEPEND}"

src_configure() {
	econf --with-charset=utf8 --enable-utf8-only
}
