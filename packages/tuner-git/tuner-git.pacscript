pkgname="tuner-git"
license="GPL-3.0"
source=("https://codeberg.org/tuner/tuner.git")
arch=("any")
pkgver="1.5.1"
makedepends=("meson" "valac" "libgtk-3-dev" "libgranite-dev" "libsoup2.4-dev" "libgstreamer1.0-dev" "libgstreamer-plugins-bad1.0-dev" "libjson-glib-dev" "libgee-0.8-dev" "libgeocode-glib-dev" "libgeoclue-2-dev" "libgeocode-glib-dev")
depends=("desktop-file-utils")
replaces=("tuner")
pkgdesc="Tuner Radio Player - development version"

prepare() {
  cd "tuner"
  meson builddir --prefix=/usr
}

build() {
  cd "tuner"
  ninja -C builddir -j"${NCPU}"
}

package() {
  cd "tuner"
  DESTDIR="${pkgdir}" ninja -C builddir install
}

post_install() {
  sudo glib-compile-schemas /usr/share/glib-2.0/schemas
  sudo update-desktop-database -q /usr/share/applications
  sudo gtk-update-icon-cache -qtf /usr/share/icons/hicolor
}

post_remove() {
  sudo update-desktop-database -q /usr/share/applications
}
