#!/bin/bash -x

if [ $# -eq 1 ]; then
    workload="$1"
    level="info"
elif [ $# -ge 2 ]; then
    workload="$1"
    level="$2"
else
    workload="workload1"
    level="info"
fi

if [ "$workload" = "workload5" ]; then
    config="config/stresstest.config"
else
    config="config/test.config"
fi

make

#dar -L $level -F $level -f --logdir `pwd`/logs/ --logfilename master.`date +"%y-%m-%d"`.log src/master.da $config $workload
dar -L $level -F $level -f --logdir logs/ --logfilename master.`date +"%y-%m-%d"`.log src/master.da $config $workload

