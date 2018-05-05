#!/bin/bash

_section "Boot AION CPU MINER"
# start CPU Miner with maximum of CPU Threads
NUMBER_CPU_THREADS=1
MINING_POOL_ADDRESS="127.0.0.1"
MINING_POOL_PORT=3333
MINING_ADDRESS="Ben"
./aionminer -t $NUMBER_CPU_THREADS -l $MINING_POOL_ADDRESS:$MINING_POOL_PORT -u $MINING_ADDRESS 2>&1 >> ~/runtime.log
_success "Started miner"