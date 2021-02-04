#!/usr/bin/env bash

# Build library
cd src
autoreconf --install
./configure --disable-shared
make -j 
sync
# Move some files
cp .libs/*.a ../
cp mpsse.h ../
cp mpsse_config.h ../
cp ftdi.h ../
cp examples/bitbang ../
cp examples/ds1305 ../
cp examples/gpio ../
cp examples/i2ceeprom ../
cp examples/spiflash ../
cp examples/spiflashfast ../
cd ../
# Build standalone libmpsse.a with libftdi1-static.a included
rm -f libmpsse-static.a
ar -x libmpsse.a
ar -x src/libftdi1-static.a
ar -qc libmpsse-static.a *.o
rm libmpsse.a
rm *.o
# Done, link libmpsse to you application with -L. -lmpsse-static -lpthreads -ludev
