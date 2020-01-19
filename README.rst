####################
ACRTA Data Warehouse
####################



***************
Getting Started
***************
Get the code::

    $ git clone 

*************
Starting Hive
*************

Build the custom Apache Hive image::

    $ docker build -f docker/hive/Dockerfile -t loum/acrta-hive docker/hive

Run the container::

    $ docker run -ti --rm -p 10000:10000 -v $PWD/data:/data -v $PWD/schemas/:/schemas --name hive loum/acrta-hive

*****************
Starting Zeppelin
*****************

Build the custom Apache Zeppelin notebook with Hive interpreter::

    $ docker build -f docker/zeppelin-hive/Dockerfile -t loum/zeppelin-hive docker/zeppelin-hive

Run the container::

    $ docker run -d -p 8080:8080 --rm -v $PWD/logs:/logs -v $PWD/docker/zeppelin-hive/notebook:/notebook -e ZEPPELIN_LOG_DIR='/logs' -e ZEPPELIN_NOTEBOOK_DIR='/notebook' -e ZEPPELIN_ADDR='0.0.0.0' --name zeppelin loum/zeppelin-hive
