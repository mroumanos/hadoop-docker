#!/bin/bash

SQOOP_VER=$1
DEST=$2

echo "========== DOWNLOADING SQOOP ($SQOOP_VER) =========="
curl -o apache-sqoop.tar.gz http://apache.cs.utah.edu/sqoop/$SQOOP_VER/sqoop-$SQOOP_VER-bin-hadoop200.tar.gz

echo "========== INSTALLING SQOOP ($SQOOP_VER) =========="
mkdir -p $DEST/apache-sqoop-$SQOOP_VER
tar -zxvf apache-sqoop.tar.gz -C $DEST/apache-sqoop-$SQOOP_VER --strip-components 1
ln -s $DEST/apache-sqoop-$SQOOP_VER $DEST/sqoop
rm apache-sqoop.tar.gz

echo "========== ADDING SQOOP TO ENVIRONMENT ($HIVE_VER)=========="
source ~/.bashrc
echo "export SQOOP_HOME=$DEST/sqoop" >> ~/.bashrc
echo "export PATH=$PATH:$DEST/sqoop/bin" >> ~/.bashrc