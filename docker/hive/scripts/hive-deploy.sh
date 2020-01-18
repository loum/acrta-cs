#!/bin/sh
set -x

HIVE_VERSION=hive-3.1.2

wget -P /tmp http://apache.mirror.serversaustralia.com.au/hive/${HIVE_VERSION}/apache-${HIVE_VERSION}-bin.tar.gz 2>&1 | grep -i "failed|error"
tar xzf /tmp/apache-${HIVE_VERSION}-bin.tar.gz -C /opt && chown -R root:root /opt/apache-${HIVE_VERSION}-bin.tar.gz
ln -s /opt/apache-${HIVE_VERSION}-bin /opt/hive
rm /tmp/apache-${HIVE_VERSION}-bin.tar.gz
