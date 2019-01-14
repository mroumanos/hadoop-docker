FROM daemon

ARG HIVE_VER

# Create a Hive user
USER root
RUN useradd -ms /bin/bash hive
RUN usermod -aG hadoop hive

# Setup Hive
COPY setup.sh hive_setup.sh
RUN chmod +x ./hive_setup.sh
RUN ./hive_setup.sh ${HIVE_VER} /usr/local/apache hive

# Change user
USER hive
WORKDIR /home/hive

