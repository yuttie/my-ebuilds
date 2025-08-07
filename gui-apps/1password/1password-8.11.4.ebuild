# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Pulled from jaredallard's overlay to GURU

EAPI=8

inherit desktop optfeature xdg

DESCRIPTION="Password Manager"
HOMEPAGE="https://1password.com"
SRC_URI="
	amd64? ( https://downloads.1password.com/linux/tar/stable/x86_64/${PN}-${PV}.x64.tar.gz -> ${P}-amd64.tar.gz )
	arm64? ( https://downloads.1password.com/linux/tar/stable/aarch64/${PN}-${PV}.arm64.tar.gz -> ${P}-arm64.tar.gz )"

S="${WORKDIR}"
LICENSE="all-rights-reserved"
SLOT="0"

KEYWORDS="~amd64 ~arm64"
IUSE="policykit"
RESTRICT="bindist mirror strip"

DEPEND="
	x11-misc/xdg-utils
	acct-group/onepassword
"
RDEPEND="${DEPEND}"

QA_PREBUILT="/opt/1Password/*"

src_prepare() {
	default
	xdg_environment_reset
}

src_install() {
	dodir /opt/1Password
	cp -ar "${S}/${PN}-"**"/"* "${ED}/opt/1Password/" || die "Install failed!"

	# Fill in policy kit file with a list of (the first 10) human users of
	# the system.
	dodir /usr/share/polkit-1/actions
	local policy_owners
	policy_owners="$(cut -d: -f1,3 /etc/passwd \
		| grep -E ':[0-9]{4}$' \
		| cut -d: -f1 \
		| head -n 10 \
		| sed 's/^/unix-user:/' \
		| tr '\n' ' ')"
	sed -e "s/\${POLICY_OWNERS}/${policy_owners}/" \
		"${ED}/opt/1Password/com.1password.1Password.policy.tpl" \
		> "${ED}/usr/share/polkit-1/actions/com.1password.1Password.policy" ||
		die "Failed to create policy file"

	fperms 644 /usr/share/polkit-1/actions/com.1password.1Password.policy

	dosym -r /opt/1Password/1password /usr/bin/1password
	dosym -r /opt/1Password/op-ssh-sign /usr/bin/op-ssh-sign

	dosym -r /opt/1Password/resources/1password.desktop /usr/share/applications/1password.desktop
	newicon "${ED}/opt/1Password/resources/icons/hicolor/512x512/apps/1password.png" "${PN}.png"

	dodoc "${ED}/opt/1Password/resources/custom_allowed_browsers"
}

pkg_postinst() {
	# chrome-sandbox requires the setuid bit to be specifically set.
	# See https://github.com/electron/electron/issues/17972
	chmod 4755 "${EROOT}"/opt/1Password/chrome-sandbox

	# This gives no extra permissions to the binary. It only hardens it against environmental tampering.
	chgrp onepassword "${EROOT}"/opt/1Password/1Password-BrowserSupport
	chmod g+s "${EROOT}"/opt/1Password/1Password-BrowserSupport

	xdg_pkg_postinst

	if [[ -z ${REPLACING_VERSIONS} ]]; then
		optfeature "1Password CLI" app-admin/op-cli-bin
	fi
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
