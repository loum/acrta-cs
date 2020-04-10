#!/bin/sh

# Prepare HDFS directories.
docker exec -ti hive bash -c "/scripts/acrta-hdfs-init.sh"

# Setup ACRTA data warehouse tables.
docker exec -ti hive sh -c "HADOOP_HOME=/opt/hadoop /opt/hive/bin/beeline -u jdbc:hive2://hive:10000 APP mine -f /scripts/acrta.hql"

# Move ACRTA data files into HDFS.
docker exec -ti hive sh -c "/scripts/acrta-data.sh"

# Load HDFS-based ACRTA data files into Hive.
docker exec -ti hive sh -c "HADOOP_HOME=/opt/hadoop /opt/hive/bin/beeline -u jdbc:hive2://hive:10000 APP mine -f /scripts/acrta-load.hql"
