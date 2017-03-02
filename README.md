# Hadoop (Single Node) with Docker from scratch.

1. Download hadoop tar.gz  and put it in the hadoop directory.
wget  http://mirrors.whoishostingthis.com/apache/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz

This container will serve out a hdfs_site.xml and core_site.xml for use in DC/OS for use with containers that require this functionality, such as mesosphere/spark, slowenthal/zeppelin-0.7.0 


The files are hard-coded to serve out the host namenode.marathon.l4lb.thisdcos.directory:9000 for the namenode.  This matches the marathon.vip.json file.

To serve out the configs just curl them from port 50070   curl http://<namenode>:50070/core_site.xml

The container uses standard ports for HDFS, but they can be remapped using the PORT0 ... PORT5 environment variables.  This is primarily to dynamically assign the ports for DC/OS. see the docker_entrypoint.sh for the port assignments.



