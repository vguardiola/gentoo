# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="forceoptional"
KDE_TEST="true"
VIRTUALX_REQUIRED="test"
inherit kde5

DESCRIPTION="Plasma filemanager focusing on usability"
HOMEPAGE="https://dolphin.kde.org https://www.kde.org/applications/system/dolphin"
KEYWORDS=" ~amd64 ~x86"
IUSE="semantic-desktop thumbnail"

DEPEND="
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kcodecs)
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep kitemviews)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kparts)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_frameworks_dep solid)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	media-libs/phonon[qt5]
	semantic-desktop? (
		$(add_frameworks_dep baloo)
		$(add_frameworks_dep kfilemetadata)
		$(add_kdeapps_dep baloo-widgets)
	)
	!semantic-desktop? (
		$(add_frameworks_dep kdelibs4support)
	)
"
RDEPEND="${DEPEND}
	$(add_kdeapps_dep kio-extras)
	thumbnail? (
		|| ( $(add_kdeapps_dep ffmpegthumbs) media-video/ffmpegthumbnailer )
		$(add_kdeapps_dep thumbnailers)
	)
"

RESTRICT="test"

src_configure() {
	local mycmakeargs=(
		-DWITH_KF5Baloo=$(usex semantic-desktop)
		-DWITH_KF5BalooWidgets=$(usex semantic-desktop)
	)

	kde5_src_configure
}

pkg_postinst() {
	kde5_pkg_postinst

	if ! has_version "kde-apps/ark:${SLOT}" ; then
		echo
		elog "For compress/extract and other actions, please install kde-apps/ark:${SLOT}"
		echo
	fi
}
