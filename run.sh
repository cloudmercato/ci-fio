#!/bin/bash

iterations=${iterations:-3}
cpu_number=$(lscpu | awk '/^CPU\(s\)/{print $2}')
threads=$(for i in $(seq 0 16); do [ $((2**i)) -le $((2*cpu_number)) ] && echo $((2**i)) ; done)
device=$(df / | awk '/^\/dev/ {print $1}')
device_size=$(df -k | awk '/^.* \/$/ {print $2}')
fio_size=$(($device_size * 3/4 * 1024))

volume_flavor_id=$(jq . .volume_flavor_id)

run_fio () {
    echo "Running $1 $2$3 #$i"
    fio --numjobs=$thread \
        --bs=$1 \
        --rw=$2$3 \
        --ioengine=sync \
        --iodepth=32 \
        --direct=1 \
        --invalidate=1 \
        --buffered=0 \
        --end_fsync=1 \
        --time_based --runtime=30 --timeout=30 \
        --filename=fio-$1-$2$3 \
        --size=$fio_size \
        --group_reporting --output-format=json --name=fio \
        | tee /fio-$1-$2$3-$i.json
    cb-client fio -n $i \
        -vf $volume_flavor_id < /fio-$1-$2$3-$i.json
    rm fio-$1-$2$3
}

for i in $(seq 1 $iterations) ; do
    for thread in $threads ; do
        run_fio 4k rand read
        run_fio 4k rand write
        run_fio 1m '' read
        run_fio 1m '' write
    done
done
