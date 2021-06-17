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

***********************************************
ACRTA Case Study Infrastructure Build and Setup
***********************************************

::

    $ make local-build-up

`Click to see the Zeppelin dashboard <http://localhost:18888>`_

For each of the following notebooks in this order, click on the "Run all paragraphs" icon::

# ``01-init|acrta_dwh``
# ``02-drive|drive_features``
# ``03-engine|engine_features``
