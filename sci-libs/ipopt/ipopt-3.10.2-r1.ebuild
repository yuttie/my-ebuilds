# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils flag-o-matic

DESCRIPTION="Ipopt is a software package for large-scale nonlinear optimization."
HOMEPAGE="https://projects.coin-or.org/Ipopt"

MY_P=${P/ipopt/Ipopt}
MUMPS_VER="4.10.0"
METIS_VER="5.0.2"
SRC_URI="http://www.coin-or.org/download/source/Ipopt/${MY_P}.tgz
		 http://mumps.enseeiht.fr/MUMPS_${MUMPS_VER}.tar.gz
		 http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-${METIS_VER}.tar.gz"
S=${WORKDIR}/${MY_P}

LICENSE="CPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="quasi-newton"

RDEPEND="virtual/blas
         quasi-newton? ( virtual/lapack )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${MY_P}.tgz || die "unpack ${MY_P}.tgz failed"

	tar xzf ${DISTDIR}/MUMPS_${MUMPS_VER}.tar.gz \
		-C ${S}/ThirdParty/Mumps || die "unpack MUMPS_${MUMPS_VER}.tar.gz failed"
	mv ${S}/ThirdParty/Mumps/MUMPS_${MUMPS_VER} ${S}/ThirdParty/Mumps/MUMPS

	tar xzf ${DISTDIR}/metis-${METIS_VER}.tar.gz \
		-C ${S}/ThirdParty/Metis || die "unpack metis-${METIS_VER}.tar.gz failed"
}

src_prepare() {
	append-cflags "-std=c89"
	sed -i -e 's!PKG_CONFIG_PATH=@COIN_PKG_CONFIG_PATH@!PKG_CONFIG_PATH=.:../ThirdParty/Mumps!' Ipopt/Makefile.in
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README
}
