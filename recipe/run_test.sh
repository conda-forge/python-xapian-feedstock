set -xue

if [[ ${PY3K} == "1" ]]; then
    EXAMPLES_DIR="${PREFIX}/share/doc/xapian-bindings/python3/examples"
else
    EXAMPLES_DIR="${PREFIX}/share/doc/xapian-bindings/python/examples"
fi

${PYTHON} "${EXAMPLES_DIR}/test/smoketest.py"
