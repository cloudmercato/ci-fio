#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export sudo=$(which sudo)

$sudo apt install libaio-dev build-essential -y
wget -q https://github.com/axboe/fio/archive/fio-3.17.tar.gz
tar xf fio-3.17.tar.gz

cd fio-fio-3.17
./configure
make
$sudo make install

$sudo ln -s /usr/local/bin/fio /bin/fio
