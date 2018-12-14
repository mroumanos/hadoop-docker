#!/bin/bash

HIVE_VER=$1
DEST=$2

echo "========== DOWNLOADING HIVE ($HIVE_VER) =========="
curl -o apache-hive.tar.gz http://apache.cs.utah.edu/hive/hive-$HIVE_VER/apache-hive-$HIVE_VER-bin.tar.gz

echo "========== INSTALLING HIVE ($HIVE_VER) =========="
mkdir -p $DEST/apache-hive-$HIVE_VER
tar -zxvf apache-hive.tar.gz -C $DEST/apache-hive-$HIVE_VER --strip-components 1
ln -s $DEST/apache-hive-$HIVE_VER $DEST/hive
rm apache-hive.tar.gz

echo "========== ADDING HIVE TO ENVIRONMENT ($HIVE_VER)=========="
source ~/.bashrc
echo "export HIVE_HOME=$DEST/hive" >> ~/.bashrc
echo "export PATH=$PATH:$DEST/hive/bin" >> ~/.bashrc