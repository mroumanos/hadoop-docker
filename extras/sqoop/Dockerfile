FROM daemon

ARG SQOOP_VER
ARG PG_DRIVER

# Create a Sqoop user
RUN useradd -ms /bin/bash sqoop2
RUN usermod -aG hadoop sqoop2

# Setup Sqoop server
COPY setup.sh sqoop_setup.sh
USER root
RUN chmod +x ./sqoop_setup.sh
USER sqoop2
RUN ./sqoop_setup.sh ${SQOOP_VER} /usr/local/hadoop ${PG_DRIVER}
