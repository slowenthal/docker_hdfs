#!/bin/bash

echo $PORT0 $PORT1 $PORT2 $PORT3 $PORT4

NAMENODEHTTP=${PORT0:-50070}
DATANODEHTTP=${PORT1:-50075}
DATANODE=${PORT2:-50010}
DATANODEIPC=${PORT3:-50020}
NAMENODE=${PORT4:-9000}
IP=`hostname -i`

if [ -z "$SERVICE_HOSTNAME"]; then
   SERVICE_HOSTNAME=$HOSTNAME:9000
fi

sed -i "s/50070/$NAMENODEHTTP/" /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i "s/50075/$DATANODEHTTP/" /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i "s/50010/$DATANODE/" /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i "s/50020/$DATANODEIPC/" /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i "s/0.0.0.0/$IP/" /opt/hadoop/etc/hadoop/hdfs-site.xml
sed -i "s/:9000/:$NAMENODE/" /opt/hadoop/etc/hadoop/core-site.xml
sed -i "s/localhost/$HOSTNAME/" /opt/hadoop/etc/hadoop/core-site.xml
sed -i "s/HOSTNAME/$SERVICE_HOSTNAME/" /opt/hadoop/share/hadoop/hdfs/webapps/hdfs/core-site.xml

export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre

cd /opt/hadoop

# Format hdfs
if [ ! -d /var/lib/hadoop/dfs ]; then
   bin/hdfs namenode -format
fi


sbin/hadoop-daemon.sh --config /opt/hadoop/etc/hadoop start namenode &
sbin/hadoop-daemon.sh --config /opt/hadoop/etc/hadoop start datanode &


#service ssh start
#/opt/hadoop/sbin/start-dfs.sh
#/opt/hadoop/sbin/start-yarn.sh

# WAIT
tail -f /dev/null

