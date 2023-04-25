set -xe

if [[ ${PY_VER} == "2.7" ]]; then
    PYFLAG="--with-python"
    PYTHON2=${PYTHON}
    PYTHON3=
    TEST_DIR="${SRC_DIR}/python"
    EXAMPLES_DIR="${PREFIX}/share/doc/xapian-bindings/python/examples"
else
    PYFLAG="--with-python3"
    PYTHON2=
    PYTHON3=${PYTHON}
    TEST_DIR="${SRC_DIR}/python3"
    EXAMPLES_DIR="${PREFIX}/share/doc/xapian-bindings/python3/examples"
fi

sed -i 's/--ltlibs/--libs/g' ./configure

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

# For our run_test.sh script
mkdir -p ${EXAMPLES_DIR}/test
cp ${TEST_DIR}/testsuite.py ${EXAMPLES_DIR}/test/
cp ${TEST_DIR}/smoketest.py ${EXAMPLES_DIR}/test/
cp ${TEST_DIR}/test_xapian_star.py ${EXAMPLES_DIR}/test/
cp ${TEST_DIR}/pythontest.py ${EXAMPLES_DIR}/test/
