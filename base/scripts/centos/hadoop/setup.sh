#!/bin/bash

HADOOP_VER=$1
DEST=$2
USER=$3

echo "========== DOWNLOADING HADOOP ($HADOOP_VER)=========="
curl -o hadoop.tar.gz http://apache.cs.utah.edu/hadoop/common/hadoop-${HADOOP_VER}/hadoop-${HADOOP_VER}.tar.gz

echo "========== UNPACKING HADOOP ($HADOOP_VER)=========="
mkdir -p $DEST
tar -zxvf hadoop.tar.gz -C $DEST
ln -s $DEST/hadoop-$HADOOP_VER $DEST/hadoop
rm hadoop.tar.gz
chown -R $USER:$USER $DEST

echo "========== ADDING HADOOP TO ENVIRONMENT ($HADOOP_VER)=========="
echo "export HADOOP_HOME=$DEST/hadoop" >> /home/$USER/.bashrc
echo "export PATH=$PATH:$DEST/hadoop/bin:$DEST/hadoop/sbin" >> /home/$USER/.bashrc

