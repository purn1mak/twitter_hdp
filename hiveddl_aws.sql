set hive.cli.errors.ignore=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.dynamic.partition=true;
set hive.enforce.bucketing = true;
SET hive.exec.compress.output=true;
SET avro.output.codec=snappy;

CREATE DATABASE IF NOT EXISTS twitter;
USE twitter;

CREATE EXTERNAL TABLE IF NOT EXISTS tweetsummary_part 
(id BIGINT, id_str STRING, created_at STRING, 
timestamp_ms STRING, lang STRING, text STRING) 
PARTITIONED BY (year string, month string, day string)
STORED AS ORC
location 's3a://pkuchikulla/tweet-lake/summary/';


ALTER TABLE tweetsummary_part ADD PARTITION (year='2018',month='07',day='13') 
location 's3a://pkuchikulla/tweet-lake/summary/2018/07/13';
ALTER TABLE tweetsummary_part ADD PARTITION (year='2018',month='07',day='18') 
location 's3a://pkuchikulla/tweet-lake/summary/2018/07/18';
ALTER TABLE tweetsummary_part ADD PARTITION (year='2018',month='07',day='22') 
location 's3a://pkuchikulla/tweet-lake/summary/2018/07/22';
ALTER TABLE tweetsummary_part ADD PARTITION (year='2018',month='07',day='23') 
location 's3a://pkuchikulla/tweet-lake/summary/2018/07/23';
ALTER TABLE tweetsummary_part ADD PARTITION (year='2018',month='07',day='24') 
location 's3a://pkuchikulla/tweet-lake/summary/2018/07/24';
