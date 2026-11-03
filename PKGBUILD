# Maintainer: Sven-Hendrik Haase <svenstaro@archlinux.org>
# Maintainer: Bruno Pagani <archange@archlinux.org>
# Contributor: Robert Schiele <rschiele@gmail.com>

pkgbase=prusa-slicer
pkgname=(prusa-slicer slicer-udev)
pkgver=3.0.0
pkgrel=1
pkgdesc="G-code generator for 3D printers (Prusa fork of Slic3r)"
arch=('x86_64')
url="https://github.com/mactul/PrusaSlicer"
license=('AGPL-3.0-only')
depends=('gtk3' 'webkit2gtk-4.1' 'mpfr' 'gmp' 'blosc' 'boost-libs' 'curl'
         'expat' 'libjpeg-turbo' 'nanosvg' 'nlopt' 'opencascade' 'opencsg'
         'openexr' 'openssl' 'openvdb' 'libpng' 'qhull' 'tbb' 'libtiff'
         'wxwidgets-gtk3' 'z3' 'zlib' 'libstdc++' 'libgcc' 'glibc' 'dbus' 'imath'
         'glib2' 'pango' 'hicolor-icon-theme' 'imath')
makedepends=('cmake' 'systemd' 'glu' 'ninja' 'git' 'python' 'boost' 'catch2'
             'cereal' 'cgal' 'libigl' 'nlohmann-json' 'glad')
options=('!makeflags')

build() {
  cd "$startdir"
  export CMAKE_POLICY_VERSION_MINIMUM=3.5

  # Fix crashes
  export CXXFLAGS=${CXXFLAGS/-Wp,-D_GLIBCXX_ASSERTIONS}

  ./compile.sh
}

check() {
  cd "$startdir"
  cd build

  ctest
}

package_prusa-slicer() {
  cd "$startdir"
  optdepends=('slicer-udev: 3D printer connection rules')

  DESTDIR="$pkgdir" ninja -C build install

  # Desktop icons
  mkdir -p "${pkgdir}"/usr/share/icons/hicolor/scalable/apps/
  ln -s /usr/share/PrusaSlicer/icons/PrusaSlicer.svg "${pkgdir}"/usr/share/icons/hicolor/scalable/apps/PrusaSlicer.svg
  ln -s /usr/share/PrusaSlicer/icons/PrusaSlicer-gcodeviewer.svg "${pkgdir}"/usr/share/icons/hicolor/scalable/apps/PrusaSlicer-gcodeviewer.svg

  # Split udev rule
  mv "${pkgdir}"/usr/lib/udev/ "$srcdir"
}

package_slicer-udev() {
  pkgdesc="udev rules for Slic3r-like software"
  depends=() # Reset dependencies

  install -d "${pkgdir}"/usr/lib/
  mv udev "${pkgdir}"/usr/lib/
}
