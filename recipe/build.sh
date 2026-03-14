set -xe

sed -i.backup 's/--ltlibs/--libs/g' configure

PYTHON3=${PYTHON} \
LDFLAGS=${LDFLAGS} \
./configure \
    XAPIAN_CONFIG="${PREFIX}/bin/xapian-config" \
    CPPFLAGS=-I${PREFIX}/include \
    LDFLAGS="-L${PREFIX}/lib" \
    --with-python3 \
    --without-php \
    --without-php7 \
    --without-ruby \
    --without-tcl \
    --without-csharp \
    --without-java \
    --without-perl \
    --without-lua \
    --prefix=${PREFIX}

make -j ${CPU_COUNT}
make install prefix=${PREFIX}

# For our run_test.sh script
EXAMPLES_DIR="${PREFIX}/share/doc/xapian-bindings/python3/examples"
TEST_DIR="${SRC_DIR}/python3"
mkdir -p ${EXAMPLES_DIR}/test
cp ${TEST_DIR}/testsuite.py ${EXAMPLES_DIR}/test/
cp ${TEST_DIR}/smoketest.py ${EXAMPLES_DIR}/test/
cp ${TEST_DIR}/test_xapian_star.py ${EXAMPLES_DIR}/test/
cp ${TEST_DIR}/pythontest.py ${EXAMPLES_DIR}/test/
