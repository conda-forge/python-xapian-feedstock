set -xu

if [[ ${PY3K} == "1" ]]; then
    PYFLAG="--with-python3"
    PYTHON2=
    PYTHON3=$PYTHON
else
    PYFLAG="--with-python"
    PYTHON2=$PYTHON
    PYTHON3=
fi

$PREFIX/bin/xapian-config --version
$PREFIX/bin/xapian-config --cxxflags
$PREFIX/bin/xapian-config --libs
$PREFIX/bin/xapian-config --ltlibs

PYTHON2=$PYTHON2 PYTHON3=$PYTHON3 \
LDFLAGS=$LDFLAGS \
./configure \
    CPPFLAGS=-I$PREFIX/include \
    --without-php \
    --without-php7 \
    --without-ruby \
    --without-tcl \
    --without-csharp \
    --without-java \
    --without-perl \
    --without-lua \
    --disable-documentation \
    $PYFLAG \
    --prefix=$PREFIX

make && make install
rm -rf $PREFIX/share/doc/xapian-bindings

