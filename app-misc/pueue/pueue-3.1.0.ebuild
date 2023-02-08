# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line-0.19.0
	adler-1.0.2
	aho-corasick-0.7.20
	android_system_properties-0.1.5
	anyhow-1.0.68
	assert_cmd-2.0.8
	async-trait-0.1.63
	autocfg-1.1.0
	backtrace-0.3.67
	base64-0.13.1
	base64-0.21.0
	better-panic-0.3.0
	bindgen-0.59.2
	bitflags-1.3.2
	block-buffer-0.10.3
	bstr-0.2.17
	bstr-1.1.0
	bumpalo-3.12.0
	byteorder-1.4.3
	bytes-1.3.0
	cc-1.0.78
	cexpr-0.6.0
	cfg-if-1.0.0
	chrono-0.4.23
	chrono-english-0.1.7
	clang-sys-1.4.0
	clap-4.1.4
	clap_complete-4.1.1
	clap_derive-4.1.0
	clap_lex-0.3.1
	codespan-reporting-0.11.1
	comfy-table-6.1.4
	command-group-2.0.1
	console-0.15.5
	core-foundation-sys-0.8.3
	cpufeatures-0.2.5
	crossterm-0.25.0
	crossterm_winapi-0.9.0
	crypto-common-0.1.6
	ctor-0.1.26
	ctrlc-3.2.4
	cxx-1.0.87
	cxx-build-1.0.87
	cxxbridge-flags-1.0.87
	cxxbridge-macro-1.0.87
	diff-0.1.13
	difflib-0.4.0
	digest-0.10.6
	dirs-4.0.0
	dirs-sys-0.3.7
	doc-comment-0.3.3
	either-1.8.0
	encode_unicode-0.3.6
	env_logger-0.10.0
	errno-0.2.8
	errno-dragonfly-0.1.2
	fastrand-1.8.0
	fuchsia-cprng-0.1.1
	futures-0.3.25
	futures-channel-0.3.25
	futures-core-0.3.25
	futures-executor-0.3.25
	futures-io-0.3.25
	futures-macro-0.3.25
	futures-sink-0.3.25
	futures-task-0.3.25
	futures-timer-3.0.2
	futures-util-0.3.25
	generic-array-0.14.6
	getrandom-0.2.8
	gimli-0.27.1
	glob-0.3.1
	half-1.8.2
	handlebars-4.3.6
	hashbrown-0.12.3
	heck-0.4.0
	hermit-abi-0.2.6
	hex-0.4.3
	humantime-2.1.0
	iana-time-zone-0.1.53
	iana-time-zone-haiku-0.1.1
	indexmap-1.9.2
	instant-0.1.12
	io-lifetimes-1.0.4
	is-terminal-0.4.2
	itertools-0.10.5
	itoa-1.0.5
	js-sys-0.3.60
	lazy_static-1.4.0
	lazycell-1.3.0
	libc-0.2.139
	libloading-0.7.4
	libproc-0.12.0
	link-cplusplus-1.0.8
	linux-raw-sys-0.1.4
	lock_api-0.4.9
	log-0.4.17
	memchr-2.5.0
	minimal-lexical-0.2.1
	miniz_oxide-0.6.2
	mio-0.8.5
	nix-0.26.2
	nom-7.1.3
	num-integer-0.1.45
	num-traits-0.2.15
	num_cpus-1.15.0
	num_threads-0.1.6
	object-0.30.3
	once_cell-1.17.0
	os_str_bytes-6.4.1
	output_vt100-0.1.3
	parking_lot-0.12.1
	parking_lot_core-0.9.6
	peeking_take_while-0.1.2
	pem-1.1.1
	pest-2.5.4
	pest_derive-2.5.4
	pest_generator-2.5.4
	pest_meta-2.5.4
	pin-project-lite-0.2.9
	pin-utils-0.1.0
	portpicker-0.1.1
	ppv-lite86-0.2.17
	predicates-2.1.5
	predicates-core-1.0.5
	predicates-tree-1.0.7
	pretty_assertions-1.3.0
	proc-macro-error-1.0.4
	proc-macro-error-attr-1.0.4
	proc-macro2-1.0.50
	procfs-0.14.2
	quote-1.0.23
	rand-0.4.6
	rand-0.8.5
	rand_chacha-0.3.1
	rand_core-0.3.1
	rand_core-0.4.2
	rand_core-0.6.4
	rcgen-0.10.0
	rdrand-0.4.0
	redox_syscall-0.2.16
	redox_users-0.4.3
	regex-1.7.1
	regex-automata-0.1.10
	regex-syntax-0.6.28
	remove_dir_all-0.5.3
	rev_buf_reader-0.3.0
	ring-0.16.20
	rstest-0.16.0
	rstest_macros-0.16.0
	rustc-demangle-0.1.21
	rustc-hash-1.1.0
	rustc_version-0.4.0
	rustix-0.36.7
	rustls-0.20.8
	rustls-pemfile-1.0.2
	rustversion-1.0.11
	ryu-1.0.12
	scanlex-0.1.4
	scopeguard-1.1.0
	scratch-1.0.3
	sct-0.7.0
	semver-1.0.16
	serde-1.0.152
	serde_cbor-0.11.2
	serde_derive-1.0.152
	serde_json-1.0.91
	serde_yaml-0.9.17
	sha2-0.10.6
	shell-escape-0.1.5
	shellexpand-3.0.0
	shlex-1.1.0
	signal-hook-0.3.14
	signal-hook-mio-0.2.3
	signal-hook-registry-1.4.0
	similar-2.2.1
	similar-asserts-1.4.2
	simplelog-0.12.0
	slab-0.4.7
	smallvec-1.10.0
	snap-1.1.0
	socket2-0.4.7
	spin-0.5.2
	static_assertions-1.1.0
	strsim-0.10.0
	strum-0.24.1
	strum_macros-0.24.3
	syn-1.0.107
	tempdir-0.3.7
	tempfile-3.3.0
	termcolor-1.1.3
	termtree-0.4.0
	test-log-0.2.11
	thiserror-1.0.38
	thiserror-impl-1.0.38
	time-0.1.45
	time-0.3.17
	time-core-0.1.0
	time-macros-0.2.6
	tokio-1.24.2
	tokio-macros-1.8.2
	tokio-rustls-0.23.4
	typenum-1.16.0
	ucd-trie-0.1.5
	unicode-ident-1.0.6
	unicode-segmentation-1.10.0
	unicode-width-0.1.10
	unsafe-libyaml-0.2.5
	untrusted-0.7.1
	version_check-0.9.4
	wait-timeout-0.2.0
	wasi-0.10.0+wasi-snapshot-preview1
	wasi-0.11.0+wasi-snapshot-preview1
	wasm-bindgen-0.2.83
	wasm-bindgen-backend-0.2.83
	wasm-bindgen-macro-0.2.83
	wasm-bindgen-macro-support-0.2.83
	wasm-bindgen-shared-0.2.83
	web-sys-0.3.60
	webpki-0.22.0
	whoami-1.3.0
	winapi-0.3.9
	winapi-i686-pc-windows-gnu-0.4.0
	winapi-util-0.1.5
	winapi-x86_64-pc-windows-gnu-0.4.0
	windows-sys-0.42.0
	windows_aarch64_gnullvm-0.42.1
	windows_aarch64_msvc-0.42.1
	windows_i686_gnu-0.42.1
	windows_i686_msvc-0.42.1
	windows_x86_64_gnu-0.42.1
	windows_x86_64_gnullvm-0.42.1
	windows_x86_64_msvc-0.42.1
	yansi-0.5.1
	yasna-0.5.1
"

inherit cargo systemd bash-completion-r1

DESCRIPTION="Manage your shell commands"
HOMEPAGE="https://github.com/nukesor/pueue"

SRC_URI="
	$(cargo_crate_uris)
	https://github.com/Nukesor/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

# as of 3.1.0 pueue is subproject
WORKSPACE="${S}"
S="${WORKSPACE}/${PN}"

src_prepare() {
	# remove darwin-libproc from pueue_lib/Cargo.toml because it gets pulled 3rd party
	# git repo but isn't really needed (considered a 'dev-dependency').
	sed -i -e "74,78d" "${WORKSPACE}/pueue_lib/Cargo.toml" || die "Failed to remove darwin-libproc dependency"

	default
}

src_install() {
	cargo_src_install

	# generate and install shell completions files
	mkdir -p ${WORKSPACE}/completions

	# bash
	${ED}/usr/bin/pueue completions bash ${WORKSPACE}/completions || die "gen bash completion failed"
	newbashcomp ${WORKSPACE}/completions/${PN}.bash ${PN}

	# zsh
	${ED}/usr/bin/pueue completions zsh ${WORKSPACE}/completions || die "gen zsh completion failed"
	insinto /usr/share/zsh/site-functions
	doins ${WORKSPACE}/completions/_${PN}

	# fish
	${ED}/usr/bin/pueue completions fish ${WORKSPACE}/completions || die "gen fish completion failed "
	insinto /usr/share/fish/vendor_completions.d
	doins ${WORKSPACE}/completions/${PN}.fish

	# systemd-service use PATH
	sed -i -e "s|\/usr\/bin\/||" ${WORKSPACE}/utils/pueued.service || die "sed failed"

	# install the systemd-service
	systemd_douserunit ${WORKSPACE}/utils/pueued.service
}
