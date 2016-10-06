#!/bin/bash -x

if [ $# -gt 1 ]; then
    level="$1"
    config="$2"
else
    level="info"
    config="config/test1.config"
fi

make

dar -L $level -F $level -f --logdir `pwd`/logs/ --logfilename master.`date +"%y-%m-%d"`.log src/master.da $config

