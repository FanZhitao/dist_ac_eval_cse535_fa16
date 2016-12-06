#!/bin/bash -x

mode="mvcc"

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

if [ "$mode" = "mvcc" ]; then
    if [ "$workload" = "workload8" ] || [ "$workload" = "workload9" ] || [ "$workload" = "workload10" ] || [ "$workload" = "workload11" ]; then
        config="config/stresstest_mvcc.config"
    else
        config="config/testmvcc.config"
    fi
else
    if [ "$workload" = "workload7" ]; then
        config="config/stresstest.config"
    elif [ "$workload" = "workload8" ]; then
        config="config/test2.config"
    else
        config="config/test.config"
    fi
fi

make


# Kill existing dar process
kill $(ps -ef | grep dar | grep -v grep | awk '{print $2}')

start_node() {
    if [ "$2" = "master" ]; then
        dar -L $level -F $level -f --logfilename logs/master.`date +"%y-%m-%d"`.log -n $1 --message-buffer-size=$((16*1024)) src/master.da $config $workload
    else # -D
        dar -L $level -F $level -f --logfilename logs/master.`date +"%y-%m-%d"`.log -n $1 -D --message-buffer-size=$((16*1024)) src/master.da $config $workload
    fi
}

start_node 'AppNode' 'master' & \
    sleep 1; start_node 'DbNode' & \
    sleep 1; start_node 'CoordNode-1' & \
    sleep 1; start_node 'CoordNode-2'
