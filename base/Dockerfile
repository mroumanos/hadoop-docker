ARG BASE_OS=centos
FROM ${BASE_OS} as base
ARG BASE_OS=centos
ARG HADOOP_VER=2.9.2
ARG JAVA_VER=8
 
WORKDIR /tmp

# Pull in setup files for Java and Hadoop 
COPY scripts/${BASE_OS}/java/setup.sh java_setup.sh
COPY scripts/${BASE_OS}/hadoop/setup.sh hadoop_setup.sh

# Make them executable and run them
RUN chmod +x hadoop_setup.sh java_setup.sh
RUN ./hadoop_setup.sh ${HADOOP_VER} /usr/local/hadoop
RUN ./java_setup.sh ${JAVA_VER} /usr/lib/jvm

# Pull in the configuration file for hadoop and only make it executable
COPY scripts/${BASE_OS}/install_deps.sh /tmp/install_deps.sh
RUN chmod +x /tmp/install_deps.sh

# Run configuration
RUN /tmp/install_deps.sh