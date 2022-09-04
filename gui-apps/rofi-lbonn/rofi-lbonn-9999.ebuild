# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3 toolchain-funcs xdg-utils

DESCRIPTION="A window switcher, run dialog and dmenu replacement - fork with wayland support"
HOMEPAGE="https://github.com/lbonn/rofi"
EGIT_REPO_URI="https://github.com/lbonn/rofi.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+drun +windowmode +wayland +xcb"

BDEPEND="
	dev-libs/wayland-protocols
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"
RDEPEND="
	dev-libs/glib:2
	x11-libs/cairo[X,xcb(+)]
	x11-libs/gdk-pixbuf:2
	x11-libs/libxcb:=
	x11-libs/libxkbcommon[X]
	x11-libs/pango[X]
	x11-libs/startup-notification
	x11-libs/xcb-util
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-wm
	x11-misc/xkeyboard-config
	!x11-misc/rofi
"
DEPEND="
	${RDEPEND}
	dev-libs/wayland
	x11-base/xorg-proto
"

src_configure() {
	local emesonargs=(
		$(meson_use drun drun)
		$(meson_use windowmode window)
		$(meson_feature wayland wayland)
		$(meson_feature xcb xcb)
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
