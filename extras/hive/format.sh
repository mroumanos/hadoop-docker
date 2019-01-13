#!/bin/bash

echo "========== FORMATTING HIVE =========="
source ~/.bashrc && schematool -dbType derby -initSchema