set -xueo -pipefail

# Build xapian-core component

cd ${SRC_DIR}/xapian-core/xapian-core-${PKG_VERSION}
LDFLAGS=${LDFLAGS} \
./configure \
    CXXFLAGS=-I${PREFIX}/include \
    --enable-shared \
    --enable-static \
    --disable-documentation \
    --prefix=${PREFIX}

make -j ${CPU_COUNT}
make install prefix=${PREFIX}

# For debugging / tracking of new components
ls ${PREFIX}
ls ${PREFIX}/bin
ls ${PREFIX}/lib
ls ${PREFIX}/include
ls ${PREFIX}/share

# Build python-xapian component

if [[ ${PY3K} == "1" ]]; then
    PYFLAG="--with-python3"
    PYTHON2=
    PYTHON3=${PYTHON}
else
    PYFLAG="--with-python"
    PYTHON2=${PYTHON}
    PYTHON3=
fi

cd ${SRC_DIR}/python-xapian/xapian-bindings-${PKG_VERSION}
PYTHON2=$PYTHON2 PYTHON3=$PYTHON3 \
LDFLAGS=$LDFLAGS \
./configure \
    CPPFLAGS=-I${PREFIX}/include \
    XAPIAN_CONFIG=${PREFIX}/bin/xapian-config \
    --without-php \
    --without-php7 \
    --without-ruby \
    --without-tcl \
    --without-csharp \
    --without-java \
    --without-perl \
    --without-lua \
    --disable-documentation \
    ${PYFLAG} \
    --prefix=${PREFIX}

make -j ${CPU_COUNT}
make install prefix=${PREFIX}
