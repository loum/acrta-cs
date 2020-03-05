#!/bin/sh

HADOOP_HOME=/opt/hadoop

# HDFS commands to create /tmp and /user/hive/warehouse (aka hive.metastore.warehouse.dir)
# and set them chmod g+w before you can create a table in Hive.
echo "Creating required ACRTA Hadoop directories ..."
$HADOOP_HOME/bin/hadoop fs -mkdir /user
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data/acrta
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data/acrta/drive
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data/acrta/weather
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data/acrta/trip
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/schemas
$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse
echo "Done."

# Add the ACRTA data warehouse schema files to HDFS.
echo "Copy over the ACRTA schemas ..."
$HADOOP_HOME/bin/hadoop fs -put /schemas/drive_schema.json /user/hive/schemas
$HADOOP_HOME/bin/hadoop fs -put /schemas/trip_schema.json /user/hive/schemas
$HADOOP_HOME/bin/hadoop fs -put /schemas/weather_schema.json /user/hive/schemas
echo "Done."
