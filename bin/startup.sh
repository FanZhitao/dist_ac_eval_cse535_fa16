#!/bin/bash -x

if [ $# -eq 1 ]; then
    workload="$1"
    level="info"
    if [ "$workload" = "workload5" ]; then
        config="config/stresstest.config"
    else
        config="config/test.config"
    fi
elif [ $# -eq 2 ]; then
    workload="$1"
    level="$2"
    config="config/test.config"
else
    workload="workload1"
    level="info"
    config="config/test.config"
fi

make

dar -L $level -F $level -f --logdir `pwd`/logs/ --logfilename master.`date +"%y-%m-%d"`.log src/master.da $config $workload

