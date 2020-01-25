#!/bin/bash

apt install libaio-dev build-essential
wget -q https://github.com/axboe/fio/archive/fio-3.17.tar.gz
tar xf fio-3.17.tar.gz

cd fio-3.17/fio-fio-3.17
./configure
make
make install
