# Hadoop Docker
> a microservice cluster for learning about big data architecture

A docker microservice ecosystem for a baseline Hadoop 2.0 cluster.

![](project.png)

## Pre-requisites

- [docker](https://docs.docker.com/install/) (1.13.0+)
- [docker-compose](https://docs.docker.com/compose/install/) (3+)

## Quickstart

Prepare cluster:
```sh
> docker network create -d bridge hadoop
> docker-compose run namenode format.sh
```
*NOTE: this step should build the base and daemon images if you have not already*

Start cluster:
```sh
> docker-compose up -d
```

Cluster status:
```sh
> docker-compose ps
           Name                         Command               State                         Ports
-----------------------------------------------------------------------------------------------------------------------
hadoop_base_1                /bin/bash                        Exit 0
hadoop_daemon_1              /bin/bash                        Exit 0
hadoop_datanode1_1           ./start.sh hadoop datanode       Up       0.0.0.0:50075->50075/tcp, 0.0.0.0:8042->8042/tcp
hadoop_datanode2_1           ./start.sh hadoop datanode ...   Up       0.0.0.0:50076->50075/tcp, 0.0.0.0:8043->8042/tcp
hadoop_historyserver_1       ./start.sh mr-jobhistory h ...   Up       0.0.0.0:19888->19888/tcp
hadoop_namenode_1            ./start.sh hadoop namenode       Up       0.0.0.0:50070->50070/tcp
hadoop_resourcemanager_1     ./start.sh yarn resourcema ...   Up       0.0.0.0:8088->8088/tcp
hadoop_secondarynamenode_1   ./start.sh hadoop secondar ...   Up       0.0.0.0:50090->50090/tcp
```

Stop cluster:
```sh
> docker-compose down
```

## Project structure

The docker image inheritance tree is as follows:
```
----base: core Hadoop binaries are installed here
    |---daemon: configuration files for Hadoop are installed here
    |   |---namenode: Hadoop Namenode
    |   |---datanode1: First Hadoop Datanode with YARN NodeManager
    |   |---datanode2: Second Hadoop Datanode with YARN NodeManager
    |   |---datanodeN: More Hadoop Datanodes with YARN NodeManager, as you wish
    |   |---secondarynamenode: Hadoop SecondaryNameNode
    |   |---resourcemanager: YARN Resource Manager
    |   |---historyserver: YARN Timeline History Server
    |   |---<subproject>: Any related Hadoop subproject where Hadoop is a dependency
```

The folder structure closely follows the Docker image inheritance:
```
|----base/: OS installation scripts for various versions of Hadoop and Java
|----daemon/: site configuration files and startup scripts
|----data/: data folders mounted to the data folders with NameNode, DataNodes, and SecondaryNameNodes containers (this allows data persistence in the cluster)
|----logs/: log folders for all running containers
|----extras/: Hadoop subprojects that can be added to the cluster
|----docker-compose.yml: architecture file, where you can set service hostnames, ports, mounted folders, etc.

```
## Endpoints
- NameNode: http://localhost:50070
- DataNode1: http://localhost:50075
- NodeManager1: http://localhost:8042
- DataNode2: http://localhost:50076
- NodeManager1: http://localhost:8043
- SecondaryNameNode: http://localhost:50090
- YARN Resource Manager: http://localhost:8088
- HistoryServer: http://localhost:19888

## Tests
While the cluster is running (`docker-compose up -d`), you can log into any one of the containers to access the Hadoop API.

### Ingest a file
```sh
> docker-compose exec namenode /bin/bash
[root@namenode tmp] hdfs dfs -mkdir /in # <-- you are now executing commands within the container
[root@namenode tmp] curl -o book.txt http://www.gutenberg.org/files/2701/2701-0.txt
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1246k  100 1246k    0     0  1846k      0 --:--:-- --:--:-- --:--:-- 1846k
[root@namenode tmp] hdfs dfs -copyFromLocal ./book.txt /in
[root@namenode tmp] hdfs dfs -ls /in/
```

### Run a MapReduce job
```sh
> docker-compose exec namenode /bin/bash
[root@namenode tmp] yarn jar /usr/local/apache/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-$HADOOP_VER.jar wordcount /in /out
...<MapReduce log output here>...
...<Can use ResourceManager and/or HistoryServer to track (http://localhost:8088 or http://localhost:19888)>...
[root@namenode tmp] hdfs dfs -cat /out/part-r-00000
...<MapReduce output file text here>...
```

### Access Hadoop through Hive
```sh
> docker-compose -f extras/docker-compose.yml run hive format.sh # this instantiates metastore, must be done before using cli
> docker-compose -f extras/docker-compose.yml run hive
hive> CREATE TABLE posts(`user` STRING, post STRING, `time` STRING)
    > ROW FORMAT DELIMITED
    > FIELDS TERMINATED BY ','
    > STORED AS TEXTFILE;
OK
Time taken: 2.233 seconds
```

### Use Sqoop to transfer between RDBMS
You can transfer data to/from an RDBMS like Postgres using Apache [Sqoop](https://sqoop.apache.org). To setup a Postgresql database, place all SQL commands to initialize the database in `extras/postgres/seed.sql` and start the database with: 
```sh
> docker-compose -f extras/docker-compose.yml up -d postgres
```
Or, connect to a pre-existing database (this may require you to install a new [connector](https://sqoop.apache.org/docs/1.99.7/user/Connectors.html))

Then, to access the Sqoop shell, run:
```sh
> docker-compose -f extras/docker-compose.yml run sqoop ./format.sh # required before starting the sqoop server
> docker-compose -f extras/docker-compose.yml run sqoop
Sqoop Shell: Type 'help' or '\h' for help.

sqoop:000>
```

### Access cluster through Jupyter
You can explore the network and services of the cluster using [Jupyter](https://jupyter.org/)
```sh
> docker-compose -f extras/docker-compose.yml up -d jupyter
```
and navigate to http://localhost:8888

## Contact
Please contact Mike Roumanos ([@mroumanos](https://github.com/mroumanos)) with any questions, comments, or requests