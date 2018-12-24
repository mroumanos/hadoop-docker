FROM base

COPY site/*-site.xml /usr/local/hadoop/hadoop/etc/hadoop/
COPY site/*-env.sh /usr/local/hadoop/hadoop/etc/hadoop/
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh