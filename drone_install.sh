#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt install libaio-dev build-essential -y
wget -q https://github.com/axboe/fio/archive/fio-2.17.tar.gz
tar xf fio-2.17.tar.gz

cd fio-fio-2.17
./configure
make
make install

ln -s /usr/local/bin/fio /bin/fio
