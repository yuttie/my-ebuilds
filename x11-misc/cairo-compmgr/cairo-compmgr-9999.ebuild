# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit git-2

DESCRIPTION="Cairo Composite Manager"
HOMEPAGE="http://cairo-compmgr.tuxfamily.org/"
SRC_URI=""
EGIT_REPO_URI="git://git.tuxfamily.org/gitroot/ccm/cairocompmgr.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="x11-libs/libXcomposite
        x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libX11
		x11-libs/libICE
		x11-libs/libSM
		>=x11-libs/cairo-1.8.0
		>=x11-libs/pixman-0.16.0
		>=x11-libs/gtk+-2.16.0
		dev-lang/vala:0.14"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/AM_PROG_VALAC/MY_PROG_VALAC/' configure.ac
	cat <<'EOS' > acinclude.m4
AC_DEFUN([MY_PROG_VALAC],
[AC_PATH_PROGS([VALAC], [valac-0.14 valac], [])
 AS_IF([test -z "$VALAC"],
   [AC_MSG_WARN([No Vala compiler found.  You will not be able to compile .vala source files.])],
   [AS_IF([test -n "$1"],
      [AC_MSG_CHECKING([$VALAC is at least version $1])
       am__vala_version=`$VALAC --version | sed 's/Vala  *//'`
       AS_VERSION_COMPARE([$1], ["$am__vala_version"],
         [AC_MSG_RESULT([yes])],
         [AC_MSG_RESULT([yes])],
         [AC_MSG_RESULT([no])
          AC_MSG_ERROR([Vala $1 not found.])])])])
])
EOS
	./autogen.sh
}

src_compile() {
	if [ -f Makefile ] || [ -f GNUmakefile ] || [ -f makefile ]; then
		emake -j1 || die "emake failed"
	fi
}

