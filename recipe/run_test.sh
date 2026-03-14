set -xue

EXAMPLES_DIR="${PREFIX}/share/doc/xapian-bindings/python3/examples"
VERBOSE=1 ${PYTHON} "${EXAMPLES_DIR}/test/smoketest.py"
VERBOSE=1 ${PYTHON} "${EXAMPLES_DIR}/test/pythontest.py"
