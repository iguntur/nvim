#!/usr/bin/env bash

curl -sSL 'http://stg-proxier.service.efishery.com/health' | jq
{
  "message": "OK",
  "status": {
    "database": "",
    "cache": "OK"
  }
}

curl -sSL 'http://stg-proxier.service.efishery.com/health'

echo '{"message":"OK","status":{"database":"","cache":"OK"}}' | jq
{
  "message": "OK",
  "status": {
    "database": "",
    "cache": "OK"
  }
}
