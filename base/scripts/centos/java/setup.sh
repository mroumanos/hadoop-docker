#!/bin/bash

JAVA_VER=$1
DEST=$2

case $JAVA_VER in
7*)
  JAVA_URL=https://download.java.net/openjdk/jdk7u75/ri/openjdk-7u75-b13-linux-x64-18_dec_2014.tar.gz
  ;;
8*)
  JAVA_URL=https://download.java.net/openjdk/jdk8u40/ri/openjdk-8u40-b25-linux-x64-10_feb_2015.tar.gz
  ;;
*)
  echo "Invalid Java version ($JAVA_VER)"
  ;;
esac

echo "========== DOWNLOADING JAVA (Java $JAVA_VER)=========="
curl -o java.tar.gz $JAVA_URL

echo "========== UNPACKING JAVA (Java $JAVA_VER)=========="
mkdir -p $DEST/java-$JAVA_VER
tar -zxvf java.tar.gz -C $DEST/java-$JAVA_VER --strip-components 1
ln -s $DEST/java-$JAVA_VER $DEST/java
rm java.tar.gz

echo "========== ADDING JAVA TO ENVIRONMENT (Java $JAVA_VER)=========="
echo "export JAVA_HOME=$DEST/java" >> ~/.bashrc

