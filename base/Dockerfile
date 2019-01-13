ARG BASE_OS=centos
FROM ${BASE_OS}

ARG BASE_OS=centos
ARG HADOOP_VER=2.9.2
ARG JAVA_VER=8
 
# Create Hadoop user
RUN useradd -ms /bin/bash hadoop

# Pull in setup files for Java and Hadoop 
COPY scripts/${BASE_OS}/java/setup.sh /tmp/java_setup.sh
COPY scripts/${BASE_OS}/hadoop/setup.sh /tmp/hadoop_setup.sh
COPY scripts/${BASE_OS}/install_deps.sh /tmp/install_deps.sh

# Make them executable and run them
RUN chmod +x /tmp/hadoop_setup.sh /tmp/java_setup.sh /tmp/install_deps.sh

# Run installations
RUN /tmp/hadoop_setup.sh ${HADOOP_VER} /usr/local/apache hadoop
RUN /tmp/java_setup.sh ${JAVA_VER} /usr/lib/jvm hadoop
RUN /tmp/install_deps.sh

# Change user
USER hadoop
WORKDIR /home/hadoop