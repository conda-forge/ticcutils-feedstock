#!/bin/bash

export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
sh bootstrap.sh
./configure --prefix=$PREFIX
make
make install

# don't exit on make check failure, otherwise we can't debug
set +e
make check
if [ $? -ne 0 ]; then
    check_result=$?
    echo "\n\n\nmake check failed, printing logs for debugging:\n"
    echo "\n\nsrc/test-suite.log:\n"
    cat src/test-suite.log
    echo "\n\nconfig.log:\n"
    cat config.log
    set -e
    exit $check_result
fi
set -e
