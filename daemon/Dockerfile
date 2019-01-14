FROM base

# Copy over configuration files
COPY site/*-site.xml /usr/local/apache/hadoop/etc/hadoop/
COPY site/*-env.sh /usr/local/apache/hadoop/etc/hadoop/
COPY site/container-executor.cfg /usr/local/apache/hadoop/etc/hadoop/container-executor.cfg

# Copy over start script for services
COPY start.sh /usr/local/bin/start.sh
USER root
RUN chmod +x /usr/local/bin/start.sh
USER hadoop