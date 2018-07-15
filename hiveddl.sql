set hive.cli.errors.ignore=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.exec.dynamic.partition=true;
set hive.enforce.bucketing = true;
SET hive.exec.compress.output=true;
SET avro.output.codec=snappy;

CREATE DATABASE IF NOT EXISTS twitter;
USE twitter;

CREATE EXTERNAL TABLE IF NOT EXISTS tweetsummary 
(id BIGINT, id_str STRING, created_at STRING, 
timestamp_ms STRING, lang STRING, text STRING) 
STORED AS ORC
location 'gs://pkgcpbucket/tweet-lake/summary/';
