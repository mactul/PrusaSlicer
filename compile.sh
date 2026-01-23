#!/bin/bash

export CMAKE_POLICY_VERSION_MINIMUM=3.5


cmake \
    -G Ninja \
    -S ./deps \
    -B build_deps \
    -DPrusaSlicer_deps_PACKAGE_EXCLUDES="Blosc;Boost;Catch2;Cereal;CGAL;CURL;Eigen;EXPAT;GMP;JPEG;json;MPFR;NanoSVG;NLopt;OCCT;OpenCSG;OpenEXR;OpenSSL;OpenVDB;PNG;Qhull;TBB;TIFF;wxWidgets;z3;ZLIB"
ninja -C build_deps

cmake \
    -G Ninja \
    -S . \
    -B build \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_PREFIX_PATH=$(pwd)/build_deps/destdir/usr/local \
    -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=ON \
    -DSLIC3R_FHS=ON \
    -DSLIC3R_PCH=OFF \
    -DSLIC3R_GTK=3
ninja -C build