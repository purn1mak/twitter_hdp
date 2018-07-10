set hive.cli.errors.ignore=true;

CREATE DATABASE IF NOT EXISTS twitter;
USE twitter;

CREATE EXTERNAL TABLE summary_tweets
PARTITIONED BY (YEAR INT, Month INT, Day INT)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
WITH SERDEPROPERTIES ('avro.schema.literal'='
{
    "namespace": "com.batchiq.samples.tweet",
    "type": "record",
    "name": "tweetsummary",
    "fields": [
        {"name": "id", "type": "long"},
        {"name": "id_str", "type": "string"},
        {"name": "created_at", "type": "string"},
        {"name": "timestamp_ms", "type": "string"},
        {"name": "lang", "type": "string"},
        {"name": "text", "type": "string"},
        
        {"name": "user", "type": {
            "type": "record",
            "name": "User",
            "fields": [
                {"name": "id", "type": "long"},
                {"name": "id_str", "type": "string"},
                {"name": "name", "type": "string"},
                {"name": "screen_name", "type": "string"},
                {"name": "location", "type": ["null", "string"]},
                {"name": "url", "type": ["null", "string"]},
                {"name": "description", "type": ["null", "string"]},
                {"name": "followers_count", "type": "long"},
                {"name": "friends_count", "type": "long"}
            ]
        }},

        {"name": "entities", "type": {
            "type": "record",
            "name": "Entities",
            "fields": [
                {"name": "hashtags", "type": {
                    "type": "array", "items": {
                        "type": "record",
                        "name": "Hashtag",
                        "fields": [
                            {"name": "text", "type": "string"}
                        ]
                    }
                }},
                {"name": "user_mentions", "type": {
                    "type": "array", "items": {
                        "type": "record",
                        "name": "UserMention",
                        "fields": [
                            {"name": "id", "type": "long"},
                            {"name": "id_str", "type": "string"},
                            {"name": "screen_name", "type": "string"},
                            {"name": "name", "type": "string"}
                        ]
                    }
                }}
            ]
        }}
    ]
}
')
STORED AS AVRO
LOCATION 's3a://pkuchikulla/tweet-lake/summary/';
