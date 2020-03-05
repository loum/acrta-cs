#!/bin/sh

HADOOP_HOME=/opt/hadoop

# HDFS commands to copy over the ACRTA data files into HDFS
echo "Copying ACRTA files into Hadoop directories ..."
$HADOOP_HOME/bin/hadoop fs -put /data/drive/drive_*.parquet /user/hive/data/acrta/drive
$HADOOP_HOME/bin/hadoop fs -put /data/trip/trip*.parquet /user/hive/data/acrta/trip
$HADOOP_HOME/bin/hadoop fs -put /data/weather/part-*.parquet /user/hive/data/acrta/weather
$HADOOP_HOME/bin/hadoop fs -put /data/vehicle.csv /user/hive/data/acrta
echo "Done."
