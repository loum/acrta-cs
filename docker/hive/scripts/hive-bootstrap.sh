#!/bin/sh
set -x

HADOOP_HOME=/opt/hadoop
HIVE_HOME=/opt/hive

/usr/sbin/sshd

# Start NameNode daemon and DataNode daemon.
$HADOOP_HOME/sbin/start-dfs.sh

# Start ResourceManager daemon and NodeManager daemon.
$HADOOP_HOME/sbin/start-yarn.sh

# HDFS commands to create /tmp and /user/hive/warehouse (aka hive.metastore.warehouse.dir)
# and set them chmod g+w before you can create a table in Hive.
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /tmp"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /tmp/data"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /tmp/data/drive"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /tmp/data/weather"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /tmp/data/trip"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /tmp/schemas"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -chmod g+w /tmp"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse"

# Starting from Hive 2.1, we need to run the schematool command below as an initialization step.
runuser -l hdfs -c "$HIVE_HOME/bin/schematool -dbType derby -initSchema"

# Start the Hiverserver2.
runuser -l hdfs -c "HADOOP_HOME=$HADOOP_HOME $HIVE_HOME/bin/hiveserver2 > /tmp/hiveserver2.out 2>&1 &"

# Add the ACRTA data warehouse schema files to HDFS.
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /schemas/drive_schema.json /tmp/schemas"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /schemas/trip_schema.json /tmp/schemas"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /schemas/weather_schema.json /tmp/schemas"

/bin/bash
