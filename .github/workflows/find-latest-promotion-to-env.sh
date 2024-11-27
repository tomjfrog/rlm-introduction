#!/bin/bash

# The intended use-case for this API call is to find the latest Promotion
# of a named Release Bundle, with some filtering to get a single promotion that meets our criteria
# It returns the RB version that was last promoted successfully to $SOURCE_ENVIRONMENT and strips the quotes

if [ $# -lt 4 ]; then
  echo "Usage: $0 <RT_TOKEN> <SIGNING_KEY_NAME> <BUNDLE_NAME> <SOURCE_ENVIRONMENT>"
  exit 1
fi

RT_TOKEN=$1
SIGNING_KEY_NAME=$2
BUNDLE_NAME=$3
SOURCE_ENVIRONMENT=$4

query_params="filter_by=$SOURCE_ENVIRONMENT&order_by=created_millis"

curl --request GET \
  --user $RT_TOKEN \
  --url "https://tomjfrog.jfrog.io/lifecycle/api/v2/promotion/records/$BUNDLE_NAME?$query_params" \
  --header "X-JFrog-Signing-Key-Name: $SIGNING_KEY_NAME" | \
jq -c '.promotions | map(select(.status == "COMPLETED")) | .[0].release_bundle_version' | tr -d '"'

