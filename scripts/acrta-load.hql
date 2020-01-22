-- ACRTA "drive" data load
LOAD DATA INPATH 'hdfs:///user/hive/data/acrta/drive/drive_*.parquet' INTO TABLE drive;

-- ACRTA "trip" data load
LOAD DATA INPATH 'hdfs:///user/hive/data/acrta/trip/trip*.parquet' INTO TABLE trip;

-- ACRTA "weather" data load
LOAD DATA INPATH 'hdfs:///user/hive/data/acrta/weather/part*.parquet' INTO TABLE weather;

-- ACRTA "vehicle" data load
LOAD DATA INPATH 'hdfs:///user/hive/data/acrta/vehicle.csv' INTO TABLE vehicle;
