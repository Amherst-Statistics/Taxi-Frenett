doy_data_2015:
  
  CREATE TABLE 
public.doy_data_2015
(
doy integer,
count integer,
avg_trip_time double precision,
avg_trip_distance double precision,
avg_total_amount double precision,
avg_tip_amount double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.doy_data_2015
OWNER TO 
postgres;

CREATE TABLE 
public.tmp1
(
doy integer,
avg_total_amount double precision,
avg_tip_amount double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.tmp1
OWNER TO 
postgres;


CREATE TABLE 
public.tmp2
(
doy integer,
count integer,
avg_trip_time double precision,
avg_trip_distance double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.tmp2
OWNER TO 
postgres;


INSERT INTO 
tmp1 (doy,avg_total_amount,avg_tip_amount) (
  SELECT 
  EXTRACT(DOY FROM tpep_pickup_datetime),
  AVG(total_amount), 
  AVG(tip_amount)
  FROM 
  data_2015
  WHERE 
  payment_type = 1
  GROUP BY 
  EXTRACT(DOY FROM tpep_pickup_datetime)
  ORDER BY 
  EXTRACT(DOY FROM tpep_pickup_datetime)
  
);



INSERT INTO 
tmp2 (doy,count,avg_trip_time,avg_trip_distance) (
  SELECT
  EXTRACT(DOY FROM tpep_pickup_datetime),
  COUNT(*),
  AVG(EXTRACT(EPOCH FROM (tpep_dropoff_datetime - tpep_pickup_datetime))), 
  AVG(trip_distance)
  FROM 
  data_2015
  GROUP BY 
  EXTRACT(DOY FROM tpep_pickup_datetime)
  ORDER BY 
  EXTRACT(DOY FROM tpep_pickup_datetime)
  
);


INSERT INTO doy_data_2015 
SELECT tmp2.doy, tmp2.count, tmp2.avg_trip_time, tmp2.avg_trip_distance, tmp1.avg_total_amount, tmp1.avg_tip_amount
FROM tmp2
INNER JOIN tmp1
ON tmp2.doy=tmp1.doy;


DROP TABLE tmp1;
DROP TABLE tmp2;






















hour_data_2015:
  
  CREATE TABLE 
public.hour_data_2015
(
hour integer,
count integer,
avg_trip_time double precision,
avg_trip_distance double precision,
avg_total_amount double precision,
avg_tip_amount double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.hour_data_2015
OWNER TO 
postgres;

CREATE TABLE 
public.tmp1
(
hour integer,
avg_total_amount double precision,
avg_tip_amount double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.tmp1
OWNER TO 
postgres;


CREATE TABLE 
public.tmp2
(
hour integer,
count integer,
avg_trip_time double precision,
avg_trip_distance double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.tmp2
OWNER TO 
postgres;


INSERT INTO 
tmp1 (hour,avg_total_amount,avg_tip_amount) (
  SELECT 
  EXTRACT(HOUR FROM tpep_pickup_datetime),
  AVG(total_amount), 
  AVG(tip_amount)
  FROM 
  data_2015
  WHERE 
  payment_type = 1
  GROUP BY 
  EXTRACT(HOUR FROM tpep_pickup_datetime)
  ORDER BY 
  EXTRACT(HOUR FROM tpep_pickup_datetime)
);



INSERT INTO 
tmp2 (hour,count,avg_trip_time,avg_trip_distance) (
  SELECT
  EXTRACT(HOUR FROM tpep_pickup_datetime),
  COUNT(*),
  AVG(EXTRACT(EPOCH FROM (tpep_dropoff_datetime - tpep_pickup_datetime))), 
  AVG(trip_distance)
  FROM 
  data_2015
  GROUP BY 
  EXTRACT(HOUR FROM tpep_pickup_datetime)
  ORDER BY 
  EXTRACT(HOUR FROM tpep_pickup_datetime)
  
);


INSERT INTO hour_data_2015 
SELECT tmp2.hour, tmp2.count, tmp2.avg_trip_time, tmp2.avg_trip_distance, tmp1.avg_total_amount, tmp1.avg_tip_amount
FROM tmp2
INNER JOIN tmp1
ON tmp2.hour=tmp1.hour;


DROP TABLE tmp1;
DROP TABLE tmp2;
























pickup_zip_data_2015:
  
  CREATE TABLE 
public.pickup_zip_data_2015
(
pickup_zip character(5),
count integer,
avg_trip_time double precision,
avg_trip_distance double precision,
avg_total_amount double precision,
avg_tip_amount double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.pickup_zip_data_2015
OWNER TO 
postgres;



CREATE TABLE 
public.tmp1
(
pickup_zip character(5),
avg_total_amount double precision,
avg_tip_amount double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.tmp1
OWNER TO 
postgres;


CREATE TABLE 
public.tmp2
(
pickup_zip character(5),
count integer,
avg_trip_time double precision,
avg_trip_distance double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.tmp2
OWNER TO 
postgres;


INSERT INTO 
tmp1 (pickup_zip,avg_total_amount,avg_tip_amount) (
  SELECT 
  pickup_zip,
  AVG(total_amount), 
  AVG(tip_amount)
  FROM 
  data_2015
  WHERE 
  payment_type = 1
  GROUP BY 
  pickup_zip
  ORDER BY 
  pickup_zip
  
);



INSERT INTO 
tmp2 (pickup_zip,count,avg_trip_time,avg_trip_distance) (
  SELECT
  pickup_zip,
  COUNT(*),
  AVG(EXTRACT(EPOCH FROM (tpep_dropoff_datetime - tpep_pickup_datetime))), 
  AVG(trip_distance)
  FROM 
  data_2015
  GROUP BY 
  pickup_zip
  ORDER BY 
  pickup_zip
  
);


INSERT INTO pickup_zip_data_2015 
SELECT tmp2.pickup_zip, tmp2.count, tmp2.avg_trip_time, tmp2.avg_trip_distance, tmp1.avg_total_amount, tmp1.avg_tip_amount
FROM tmp2
INNER JOIN tmp1
ON tmp2.pickup_zip=tmp1.pickup_zip;


DROP TABLE tmp1;
DROP TABLE tmp2;























dropoff_zip_data_2015:
  
  CREATE TABLE 
public.dropoff_zip_data_2015
(
dropoff_zip character(5),
count integer,
avg_trip_time double precision,
avg_trip_distance double precision,
avg_total_amount double precision,
avg_tip_amount double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.dropoff_zip_data_2015
OWNER TO 
postgres;


CREATE TABLE 
public.tmp1
(
dropoff_zip character(5),
avg_total_amount double precision,
avg_tip_amount double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.tmp1
OWNER TO 
postgres;


CREATE TABLE 
public.tmp2
(
dropoff_zip character(5),
count integer,
avg_trip_time double precision,
avg_trip_distance double precision
)
WITH (
  OIDS=FALSE
);
ALTER TABLE 
public.tmp2
OWNER TO 
postgres;


INSERT INTO 
tmp1 (dropoff_zip,avg_total_amount,avg_tip_amount) (
  SELECT 
  dropoff_zip,
  AVG(total_amount), 
  AVG(tip_amount)
  FROM 
  data_2015
  WHERE 
  payment_type = 1
  GROUP BY 
  dropoff_zip
  ORDER BY 
  dropoff_zip
  
);



INSERT INTO 
tmp2 (dropoff_zip,count,avg_trip_time,avg_trip_distance) (
  SELECT
  dropoff_zip,
  COUNT(*),
  AVG(EXTRACT(EPOCH FROM (tpep_dropoff_datetime - tpep_pickup_datetime))), 
  AVG(trip_distance)
  FROM 
  data_2015
  GROUP BY 
  dropoff_zip
  ORDER BY 
  dropoff_zip
  
);


INSERT INTO dropoff_zip_data_2015 
SELECT tmp2.dropoff_zip, tmp2.count, tmp2.avg_trip_time, tmp2.avg_trip_distance, tmp1.avg_total_amount, tmp1.avg_tip_amount
FROM tmp2
INNER JOIN tmp1
ON tmp2.dropoff_zip=tmp1.dropoff_zip;


DROP TABLE tmp1;
DROP TABLE tmp2;

