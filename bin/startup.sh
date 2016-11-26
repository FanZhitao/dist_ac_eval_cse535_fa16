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

if [ "$workload" = "workload7" ]; then
    config="config/stresstest.config"
elif [ "$workload" = "workload8" ]; then
    config="config/test2.config"
else
    #config="config/test.config"
    config="config/testmvcc.config"
fi

make


# Kill existing dar process
kill $(ps -ef | grep dar | grep -v grep | awk '{print $2}')

dar -L $level -F $level -f --logfilename logs/master.`date +"%y-%m-%d"`.log -n "AppNode" src/master.da $config $workload & \
    sleep 5; dar -L $level -F $level -f --logfilename logs/master.`date +"%y-%m-%d"`.log -n "DbNode" -D src/master.da $config $workload

