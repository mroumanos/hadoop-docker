FROM daemon

ARG HIVE_VER

COPY setup.sh hive_setup.sh
RUN chmod +x ./hive_setup.sh
RUN ./hive_setup.sh ${HIVE_VER} /usr/local/hadoop
