FROM daemon

ARG SQOOP_VER
ARG PG_DRIVER

COPY setup.sh sqoop_setup.sh
RUN chmod +x ./sqoop_setup.sh
RUN ./sqoop_setup.sh ${SQOOP_VER} /usr/local/hadoop ${PG_DRIVER}
