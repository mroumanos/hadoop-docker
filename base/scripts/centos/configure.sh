#!/bin/bash

echo "========== INSTALLING DEPENDENCIES =========="
yum install which openssh-server openssh-clients rsync -y && yum clean all