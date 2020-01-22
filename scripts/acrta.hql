-- Create the drive_avro AVRO table in Hive based on the AVRO Schema.
CREATE TABLE drive_avro
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS AVRO
TBLPROPERTIES ('avro.schema.url'='/user/hive/schemas/drive_schema.json');

-- Create the drive Parquet table in Hive based on drive_avro table
CREATE EXTERNAL TABLE drive
LIKE drive_avro
STORED AS PARQUET
LOCATION 'hdfs:///user/hive/warehouse/drive'
TBLPROPERTIES ("parquet.compression"="SNAPPY");

-- Create the trip_avro AVRO table in Hive based on the AVRO Schema.
CREATE TABLE trip_avro
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS AVRO
TBLPROPERTIES ('avro.schema.url'='/user/hive/schemas/trip_schema.json');

-- Create the trip Parquet table in Hive based on trip_avro table
CREATE EXTERNAL TABLE trip
LIKE trip_avro
STORED AS PARQUET
LOCATION 'hdfs:///user/hive/warehouse/trip'
TBLPROPERTIES ("parquet.compression"="SNAPPY");

-- Create the weather_avro AVRO table in Hive based on the AVRO Schema.
CREATE TABLE weather_avro
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
STORED AS AVRO
TBLPROPERTIES ('avro.schema.url'='/user/hive/schemas/weather_schema.json');

-- Create the weather Parquet table in Hive based on weather_avro table
CREATE EXTERNAL TABLE weather
LIKE weather_avro
STORED AS PARQUET
LOCATION 'hdfs:///user/hive/warehouse/weather'
TBLPROPERTIES ("parquet.compression"="SNAPPY");

-- Create the vehicle textfile table in Hive based on vehicle table
CREATE EXTERNAL TABLE vehicle (
    vehicle_id INT,
    year INT,
    make STRING,
    Model STRING,
    drivetrain INT,
    max_torque INT,
    max_horsepower INT,
    max_horsepower_rpm INT,
    max_torque_rpm INT,
    engine_displacement INT,
    fuel_type INT,
    fuel_tank_capacity INT,
    fuel_economy_city INT,
    fuel_economy_highway INT,
    cylinders INT,
    forced_induction INT,
    device_generation INT
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION 'hdfs:///user/hive/warehouse/vehicle';
