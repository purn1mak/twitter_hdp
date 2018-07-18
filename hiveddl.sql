set hive.cli.errors.ignore=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.dynamic.partition=true;
set hive.enforce.bucketing = true;
SET hive.exec.compress.output=true;
SET avro.output.codec=snappy;

CREATE DATABASE IF NOT EXISTS twitter;
USE twitter;

//// Twitter Tables

CREATE EXTERNAL TABLE IF NOT EXISTS tweetsummary_part 
(id BIGINT, id_str STRING, created_at STRING, 
timestamp_ms STRING, lang STRING, text STRING) 
PARTITIONED BY (year string, month string, day string)
STORED AS ORC
location 'gs://pkgcpbucket/tweet-lake/summary/';

//select * from tweetsummary_part ;
// nothing returns.

ALTER TABLE tweetsummary_part ADD PARTITION (year='2018',month='07',day='13') 
location 'gs://pkgcpbucket/tweet-lake/summary/2018/07/13';

//select * from tweetsummary_part ;
//select * from tweetsummary_part where year='2018'and month='07'and day='13';
