set -xue

PYTHON_VERSION_MAJOR=$(${PYTHON} -c "import sys; print(sys.version_info.major)")

# Some of the smoketests currently fail on Py2k, so we only run them on Py3k
if [[ ${PYTHON_VERSION_MAJOR} == "2" ]]; then
  EXAMPLES_DIR="${PREFIX}/share/doc/xapian-bindings/python/examples"
  RUN_TESTS=0
elif [[ ${PYTHON_VERSION_MAJOR} == "3" ]]; then
  EXAMPLES_DIR="${PREFIX}/share/doc/xapian-bindings/python3/examples"
  RUN_TESTS=1
else
  echo "error determining Python major version"
  exit 1
fi

if [[ ${RUN_TESTS} == 1 ]]; then
  VERBOSE=1 ${PYTHON} "${EXAMPLES_DIR}/test/smoketest.py"
  VERBOSE=1 ${PYTHON} "${EXAMPLES_DIR}/test/pythontest.py"
fi
