#!/bin/bash

HIVE_VER=$1
DEST=$2
USER=$3

echo "========== DOWNLOADING HIVE ($HIVE_VER) =========="
curl -o apache-hive.tar.gz http://apache.cs.utah.edu/hive/hive-$HIVE_VER/apache-hive-$HIVE_VER-bin.tar.gz

echo "========== INSTALLING HIVE ($HIVE_VER) =========="
mkdir -p $DEST/apache-hive-$HIVE_VER
tar -zxvf apache-hive.tar.gz -C $DEST/apache-hive-$HIVE_VER --strip-components 1
ln -s $DEST/apache-hive-$HIVE_VER $DEST/hive
rm apache-hive.tar.gz
chown -R $USER:$USER $DEST/hive $DEST/apache-hive-$HIVE_VER

echo "========== ADDING HIVE TO ENVIRONMENT ($HIVE_VER)=========="
source /home/hadoop/.bashrc
echo "export HADOOP_HOME=$(echo $HADOOP_HOME)" >> /home/$USER/.bashrc
echo "export JAVA_HOME=$(echo $JAVA_HOME)" >> /home/$USER/.bashrc
echo "export HIVE_HOME=$DEST/hive" >> /home/$USER/.bashrc
echo "export PATH=$PATH:$DEST/hive/bin" >> /home/$USER/.bashrc