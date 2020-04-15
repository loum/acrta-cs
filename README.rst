####################
ACRTA Data Warehouse
####################


*************
Prerequisties
*************

- `Docker <https://docs.docker.com/install/>`_
- `GNU make <https://www.gnu.org/software/make/manual/make.html>`_

***************
Getting Started
***************

Get the code and change into the top level ``git`` project directory::

    $ git clone https://github.com/loum/acrta-cs.git && cd acrta-cs

.. note::

    Run all commands from the top-level directory of the ``git`` repository.

For first-time setup, get the `Makester project <https://github.com/loum/makester.git>`_::

    $ git submodule update --init

Keep `Makester project <https://github.com/loum/makester.git>`_ up-to-date with::

    $ git submodule update --remote --merge

Setup the environment::

    $ make init

Data Files
==========

Manually copy the ACRTA data files under the ``data`` directory within the project as they are not part of
the repository.  The file layout should follow this structure for initialisation to succeed::

    $ tree -L 1 data
    data
    ├── drive
    ├── trip
    ├── vehicle.csv
    └── weather

***********************************************************************
ACRTA Case Study Infrastructure Build and Setup - "I'm in a hurry" Mode
***********************************************************************

::

    $ make local-build-up

`Click to see the Zeppelin dashboard <http://localhost:8080>`_

Click on the "Run all paragraphs" icon for the following notebooks in this order::

# ``01-init|acrta_dwh``
# ``02-drive|drive_features``
# ``03-engine|engine_features``

***************************************************************
ACRTA Case Study Infrastructure Build and Setup - Detailed Mode
***************************************************************

Using ``docker run``
====================

Hive
----

Build the custom Apache Hive image::

    $ docker build -f docker/hive/Dockerfile -t loum/acrta-hive docker/hive

Run the container::

    $ docker run -ti --rm -p 10000:10000 -v $PWD/data:/data -v $PWD/schemas/:/schemas -v $PWD/scripts:/scripts --name hive loum/acrta-hive

Zeppelin
--------

Build the custom Apache Zeppelin notebook with Hive interpreter::

    $ docker build -f docker/zeppelin-hive/Dockerfile -t loum/zeppelin-hive docker/zeppelin-hive

Run the container::

    $ docker run -d -p 8080:8080 --rm -v $PWD/logs:/logs -v $PWD/docker/zeppelin-hive/notebook:/notebook -e ZEPPELIN_LOG_DIR='/logs' -e ZEPPELIN_NOTEBOOK_DIR='/notebook' -e ZEPPELIN_ADDR='0.0.0.0' --name zeppelin loum/zeppelin-hive

ACRTA Hive Init and Data Load
=============================

.. note::

     Data warehouse setup must be performed after a fresh start up of the ACRTA Case Study infrastructure.

To prepare the ACRTA HDFS directories and create the ACRTA Data Warehouse tables::

    $ ./hive-init.sh
