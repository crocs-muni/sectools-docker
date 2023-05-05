#!/bin/bash

mkdir /data && cd /data;

dd if=/dev/urandom of=10MB_random.bin bs=1024 count=$((1024*10))
dd if=/dev/zero of=10MB_zero.bin bs=1024 count=$((1024*10))

cd /rtt/configuration_files
./../randomness-testing-toolkit -f ../../data/10MB_random.bin -b nist_sts -c based_on_data_length/10MB.json
./../randomness-testing-toolkit -f ../../data/10MB_zero.bin -b dieharder -c based_on_data_length/10MB.json