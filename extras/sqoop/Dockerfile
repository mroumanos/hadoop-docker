FROM daemon

ARG SQOOP_VER

COPY setup.sh sqoop_setup.sh
RUN chmod +x ./sqoop_setup.sh
RUN ./sqoop_setup.sh ${SQOOP_VER} /usr/local/hadoop
RUN ./sqoop_setup.sh ${SQOOP_VER} /usr/local/hadoop

