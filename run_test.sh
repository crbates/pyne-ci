set -x
set -e

export DYLD_LIBRARY_PATH=`pwd`/install/lib:$DYLD_LIBRARY_PATH
export DYLD_FALLBACK_LIBRARY_PATH=`pwd`/../install/lib/python2.7/site-packages/pyne/lib:$DYLD_FALLBACK_LIBRARY_PATH
export PYTHONPATH=`pwd`/install/lib/python2.7/site-packages:$PYTHONPATH:`pwd`/install
export LD_LIBRARY_PATH=`pwd`/install/lib/:$LD_LIBRARY_PATH
export PATH=$PATH:`pwd`/install/bin

`pwd`/install/bin/nosetests -w tests

exit $?
