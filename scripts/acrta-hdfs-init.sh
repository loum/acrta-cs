#!/bin/sh

HADOOP_HOME=/opt/hadoop

# HDFS commands to create /tmp and /user/hive/warehouse (aka hive.metastore.warehouse.dir)
# and set them chmod g+w before you can create a table in Hive.
echo "Creating required ACRTA Hadoop directories ..."
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data/acrta"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data/acrta/drive"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data/acrta/weather"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/data/acrta/trip"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/schemas"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -mkdir /user/hive/warehouse"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse"
echo "Done."

# Add the ACRTA data warehouse schema files to HDFS.
echo "Copy over the ACRTA schemas ..."
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /schemas/drive_schema.json /user/hive/schemas"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /schemas/trip_schema.json /user/hive/schemas"
runuser -l hdfs -c "$HADOOP_HOME/bin/hadoop fs -put /schemas/weather_schema.json /user/hive/schemas"
echo "Done."
