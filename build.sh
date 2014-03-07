set -x
set -e

mkdir -p `pwd`/install/lib/python2.7/site-packages

export PATH=`pwd`/install/bin:`pwd`/install/usr/local/bin:$PATH
echo $PATH
export PYTHONPATH=`pwd`/install/lib/python2.7/site-packages:`pwd`/install/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export DYLD_FALLBACK_LIBRARY_PATH=`pwd`/install/lib/python2.7/site-packages/pyne/lib:$DYLD_FALLBACK_LIBRARY_PATH
export C_INCLUDE_PATH=`pwd`/install/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=`pwd`/install/include:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=`pwd`/install/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=`pwd`/install/lib:$LD_LIBRARY_PATH

cd hdf5-1.8.4
./configure --prefix=`pwd`/../install --enable-shared 
make
make install
cd ..

cd moab-4.6.2
./configure --prefix=`pwd`/../install --enable-shared --with-hdf5=`pwd`/../install
make
make install
cd ..

cd nose
python setup.py install --prefix=`pwd`/../install
cd ..

cd numpy
python setup.py install --prefix=`pwd`/install
cd ..

cd cython
python setup.py install --prefix=`pwd`/install
cd ..

cd scipy
python setup.py install --prefix=`pwd`/install
cd ..

cd numexpr
python setup.py install --prefix=`pwd`/install
cd ..

tar -pczf results.tar.gz install

cd PyTables
python setup.py install --prefix=`pwd`/install --hdf5=`pwd`/install
cd ..

cd pyne
python setup.py install --prefix=`pwd`/../install --hdf5=`pwd`/../install -- -DMOAB_INCLUDE_DIR=`pwd`/../install/include -DMOAB_LIBRARY=`pwd`/../install/lib

cd scripts
env
nuc_data_make

cd ../..
exit $?