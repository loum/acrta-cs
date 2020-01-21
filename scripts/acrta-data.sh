#!/bin/sh

HADOOP_HOME=/opt/hadoop

# HDFS commands to copy over the ACRTA data files into HDFS
echo "Copying ACRTA files into Hadoop directories ..."
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /data/drive/drive_*.parquet /tmp/data/drive"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /data/trip/trip*.parquet /tmp/data/trip"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /data/weather/part-*.parquet /tmp/data/weather"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /data/vehicle.csv /tmp/data"
echo "Done."
