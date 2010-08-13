# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit cmake-utils

DESCRIPTION="Box2D is an open source C++ engine for simulating rigid bodies in 2D."
HOMEPAGE="http://www.box2d.org"

MY_PN=Box2D
MY_P=${MY_PN}_v${PV}
SRC_URI="http://box2d.googlecode.com/files/${MY_P}.zip"
S=${WORKDIR}/${MY_P}/Box2D

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="${RDEPEND}
        app-arch/unzip"

src_configure() {
	mycmakeargs="${mycmakeargs}
	             -DBOX2D_INSTALL=ON
				 -DBOX2D_BUILD_SHARED=ON
				 -DBOX2D_BUILD_STATIC=ON
				 -DBOX2D_BUILD_EXAMPLES=OFF"
	use doc && mycmakeargs="${mycmakeargs} -DBOX2D_INSTALL_DOC=ON"

	cmake-utils_src_configure
}
