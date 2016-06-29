SAMPLE R CODE FOR REVERSE GEOCODING LAT/LONG TO ZIP.

PATRICK FRENETT JUNE 2016



COPY sample FROM 'C:\samplebefore.csv' CSV HEADER;


ALTER TABLE sample ADD pickup_location geometry;
ALTER TABLE sample ADD dropoff_location geometry;
ALTER TABLE sample ADD pickup_zip CHAR(5);
ALTER TABLE sample ADD dropoff_zip CHAR(5);

UPDATE sample SET pickup_location = ST_SetSRID(ST_MakePoint(pickup_longitude, pickup_latitude),4326);
UPDATE sample SET dropoff_location = ST_SetSRID(ST_MakePoint(dropoff_longitude, dropoff_latitude),4326);

UPDATE sample SET pickup_zip = zip_codes.postalcode FROM zip_codes WHERE ST_Within(sample.pickup_location, zip_codes.geom);
UPDATE sample SET dropoff_zip = zip_codes.postalcode FROM zip_codes WHERE ST_Within(sample.dropoff_location, zip_codes.geom);


COPY sample 'C:\sampleafter.csv' DELIMITER ',' CSV HEADER;