# Apache Flink demo example
This is a starter repo for Apache Flink docker.

## Build
```
git clone https://github.com/gezims/flink-starter
cd flink-starter
mvn clean package
```

## Running the application on a Flink standalone cluster via Flink Docker using BDE Pipeline

The flink-starter flow consists of the following steps:

1. Setup HDFS
2. Setup Flink cluster
3. Put input file on HDFS
4. Compute aggregations
5. Get output from HDFS

To run the flink-starter application as a BDE pipeline, execute the following commands:
```
  git clone https://github.com/gezims/flink-starter
  cd flink-starter

  cd csswrapper/ && make hosts && cd ..

  docker create network hadoop
  docker-compose up -d
```
Note:To make it run, you may need to modify your /etc/hosts file. There is a Makefile, which will do it automatically for you (you should clean up your /etc/hosts after demo).

## Running the application on a Flink standalone cluster via Docker

To run the application, execute the following steps:

1. Setup a Flink cluster as described on http://github.com/big-data-europe/docker-flink.
2. Build the Docker image: 
`docker build --rm=true -t bde/flink-starter .`
3. Run the Docker container: 
`docker run --name flink-starter-app -e ENABLE_INIT_DAEMON=false --link flink-master:flink-master  -d bde/flink-starter`

## Running the application on a Flink standalone cluster via Flink/HDFS Workbench

Flink/HDFS Workbench Docker Compose file contains HDFS Docker (one namenode and two datanodes), Flink Docker (one master and one worker) and HUE Docker as an HDFS File browser to upload files into HDFS easily. Then, this workbench will play a role as for flink-starter application to perform computations.
Let's get started and deploy our pipeline with Docker Compose. 
Run the pipeline:

  ```
docker network create hadoop
docker-compose up -d
  ```
First, let’s throw some data into our HDFS now by using Hue FileBrowser runing in our network. To perform these actions navigate to http://your.docker.host:8088/home. Use “hue” username with any password to login into the FileBrowser (“hue” user is set up as a proxy user for HDFS, see hadoop.env for the configuration parameters). Click on “File Browser” in upper right corner of the screen and use GUI to create /user/root/input and /user/root/output folders and upload the data file into /input folder.
Go to http://your.docker.host:50070 and check if the file exists under the path ‘/user/root/input/yourfile’.

After we have all the configuration needed for our example, let’s rebuild flink-starter.

```
docker build --rm=true -t bde/flink-starter .
```
And then just run this image:
```
docker run --name flink-starter-app --net hadoop --link flink-master:flink-master \
-e ENABLE_INIT_DAEMON=false \
-e FLINK_MASTER_PORT_6123_TCP_ADDR=flink-master \
-e FLINK_MASTER_PORT_6123_TCP_PORT=6123 \
-d bde/flink-starter
```

