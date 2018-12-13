#!/bin/bash

# check for proper number of arguments
if [ $# -le 1 ]; then
  echo "Usage: start.sh [service1] [module1] [service2] [module2] .. (e.g. start.sh hadoop namenode)"
  exit 1
fi

# check for multiples of two
if [ ! $(($# % 2)) -eq 0 ]; then
    echo "provide pairs of two arguments, service and module"
    exit 1
fi

declare -a SERVICES=()
declare -a MODULES=()
declare -a PIDS=()

for((iter=1;iter<$#;iter+=2)) {
    SERVICES[${#SERVICES[@]}]=${!iter}
    jiter=$((iter+1))
    MODULES[${#MODULES[@]}]=${!jiter}
}

for((iter=0;iter<${#SERVICES[@]};iter+=1)) {

    SERVICE=${SERVICES[$iter]}
    MODULE=${MODULES[$iter]}

    echo "========== SERVICE =========="
    echo "$SERVICE-daemon.sh start $MODULE"

    echo "========== ENVIRONMENT =========="
    source ~/.bashrc
    echo $(printenv)

    echo "========== STARTING =========="
    outfile=$($SERVICE-daemon.sh start $MODULE | awk '{print $NF}' )
    base=$(basename -- ${outfile::-4})
    logfile=$base.log
    echo "$SERVICE $MODULE service started"
    echo "logs written to $logfile"

    echo "========== RUNNING =========="
    pidfile=/tmp/${base::-$(echo $HOSTNAME | wc -m)}.pid
    echo $pidfile
    PIDS[${#PIDS[@]}]=$pidfile
    if [ ! -f $pidfile ]; then
        echo "daemon did NOT run"
        echo "see logs in $logfile"
        exit_daemon
    else
        pid=$(cat $pidfile)
        echo "daemon running at $pid"
    fi
}

function exit_daemon {
    echo "shutdown received: stopping daemon"
    for((iter=0;iter<${#SERVICES[@]};iter++)) {
        SERVICE=${SERVICES[$iter]}
        MODULE=${MODULES[$iter]}
        echo "shutting down $SERVICE $MODULE"
        $SERVICE-daemon.sh stop $MODULE
    }
    exit 0
}

trap exit_daemon SIGINT SIGTERM

echo "========== ACTIVE =========="
echo "all services running..."
MODULO=${#PIDS[@]}
ITER=0
while [ -e ${PID[$ITER]} ]; do
    ITER=$((ITER+1))
    ITER=$((ITER%MODULO))
    sleep 5;
done
