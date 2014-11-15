curl -XDELETE "http://localhost:9200/myindex"
 
# insert some data
curl -XPOST "http://localhost:9200/myindex/log/_bulk" -d'
{ "index": {}}
{ "num": 1, "date": "2014-01-01"}
{ "index": {}}
{ "num": 2, "date": "2014-01-02"}
{ "index": {}}
{ "num": 3, "date": "2014-01-03"}
{ "index": {}}
{ "num": 4, "date": "2014-01-04"}
{ "index": {}}
{ "num": 5, "date": "2014-01-05"}
{ "index": {}}
{ "num": 6, "date": "2014-01-06"}
{ "index": {}}
{ "num": 7, "date": "2014-01-07"}
{ "index": {}}
{ "num": 8, "date": "2014-01-08"}
{ "index": {}}
{ "num": 9, "date": "2014-01-09"}
{ "index": {}}
{ "num": 10, "date": "2014-01-10"}
{ "index": {}}
{ "num": 11, "date": "2014-01-11"}
{ "index": {}}
{ "num": 12, "date": "2014-01-12"}
{ "index": {}}
{ "num": 13, "date": "2014-01-13"}
{ "index": {}}
{ "num": 14, "date": "2014-01-14"}
{ "index": {}}
{ "num": 15, "date": "2014-01-15"}
'
 
# Use a date_range agg to specify all of the overlapping ranges
# in this case, we're using a rolling average over a 10 day period
curl -XGET "http://localhost:9200/myindex/_search?size=0" -d'
{
  "aggs": {
    "dates": {
      "date_range": {
        "field": "date",
        "format": "YYYY-MM-dd", 
        "ranges": [
          {
            "from": "now/d-15d",
            "to": "now/d-5d"
          },
          {
            "from": "now/d-14d",
            "to": "now/d-4d"
          },
          {
            "from": "now/d-13d",
            "to": "now/d-3d"
          },
          {
            "from": "now/d-12d",
            "to": "now/d-2d"
          },
          {
            "from": "now/d-11d",
            "to": "now/d-1d"
          },
          {
            "from": "now/d-10d",
            "to": "now/d"
          }
        ]
      }
    }
  }
}'
 
# Use a script to convert each date into multiple values, one for each window
# Currently limited to 4, but will be fixed in 1.1.0
curl -XGET "http://localhost:9200/myindex/_search?size=0" -d'
{
  "aggs": {
    "dates": {
      "date_histogram": {
        "script": "v=doc[\"date\"].value; vals = [v]; for (i: days) { vals += (v - i * 24 * 60 * 60 * 1000) }; return vals",
        "params": {
          "days": 3
        },
        "interval": "day",
        "format": "YYYY-MM-dd" 
      },
      "aggs": {
        "rolling_avg": {
          "avg": {
            "field": "num"
          }
        }
      }
    }
  }
}'