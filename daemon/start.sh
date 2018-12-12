#!/bin/bash

SERVICE=$1
MODULE=$2

usage="Usage: start.sh [service] [module] (e.g. start.sh hadoop namenode)"

if [ $# -le 1 ]; then
  echo $usage
  exit 1
fi

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
pidfile=/tmp/${base::-$(echo $MODULE | wc -m)}.pid
if [ ! -f $pidfile ]; then
    echo "daemon NOT running"
    echo "see logs in $logfile"
    exit 1
else
    pid=$(cat $pidfile)
    echo "daemon running at $pid"
fi

trap exit_daemon SIGINT SIGTERM
function exit_daemon {
    echo "shutdown received: stopping daemon"
    $SERVICE-daemon.sh stop $MODULE
    exit 0
}

while [ -e /proc/$pid ]; do
    sleep 1;
done

