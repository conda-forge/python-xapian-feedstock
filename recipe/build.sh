set -xe

if [[ ${PY3K} == "1" ]]; then
    PYFLAG="--with-python3"
    PYTHON2=
    PYTHON3=${PYTHON}
else
    PYFLAG="--with-python"
    PYTHON2=${PYTHON}
    PYTHON3=
fi

PYTHON2=${PYTHON2} PYTHON3=${PYTHON3} \
LDFLAGS=${LDFLAGS} \
./configure \
    CPPFLAGS=-I${PREFIX}/include \
    --without-php \
    --without-php7 \
    --without-ruby \
    --without-tcl \
    --without-csharp \
    --without-java \
    --without-perl \
    --without-lua \
    $PYFLAG \
    --prefix=${PREFIX}

make -j ${CPU_COUNT}
make install prefix=${PREFIX}
