-- ACRTA "drive" data load
LOAD DATA INPATH 'hdfs:///tmp/data/drive/drive_*.parquet' INTO TABLE drive

-- ACRTA "trip" data load
LOAD DATA INPATH 'hdfs:///tmp/data/trip/trip*.parquet' INTO TABLE trip

-- ACRTA "weather" data load
LOAD DATA INPATH 'hdfs:///tmp/data/weather/*.parquet' INTO TABLE weather

-- ACRTA "vehicle" data load
LOAD DATA INPATH 'hdfs:///tmp/data/vehicle.csv' INTO TABLE vehicle
