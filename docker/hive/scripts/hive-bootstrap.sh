#!/bin/sh

HADOOP_HOME=/opt/hadoop
HIVE_HOME=/opt/hive

/usr/sbin/sshd

# Start NameNode daemon and DataNode daemon.
$HADOOP_HOME/sbin/start-dfs.sh

# Start ResourceManager daemon and NodeManager daemon.
$HADOOP_HOME/sbin/start-yarn.sh

# Starting from Hive 2.1, we need to run the schematool command below as an initialization step.
echo "Hive initialisation ..."
runuser -l hdfs -c "$HIVE_HOME/bin/schematool -dbType derby -initSchema"
echo "Done."

# Start the Hiverserver2.
echo "Starting the Hiverserver2 in background ..."
runuser -l hdfs -c "HADOOP_HOME=$HADOOP_HOME $HIVE_HOME/bin/hiveserver2 > /tmp/hiveserver2.out 2>&1 &"
echo "Done."

# Block Hadoop until we signal exit.
trap 'exit 0' TERM
while true; do :; done
