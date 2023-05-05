#!/bin/bash

dd if=/dev/urandom of=random-file.bin bs=1024 count=$((1024*10))
dd if=/dev/zero of=zero-file.bin bs=1024 count=$((1024*10))

booltest --degree 2 --block 256 --combine-deg 2 --top 128 --tv $((1024*1024*10)) --rounds 0 random-file.bin
booltest --degree 2 --block 256 --combine-deg 2 --top 128 --tv $((1024*1024*10)) --rounds 0 zero-file.bin