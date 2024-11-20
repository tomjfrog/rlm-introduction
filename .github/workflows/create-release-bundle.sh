#!/bin/bash
if [ $# -lt 2 ]; then
  echo "Usage: $0 <URL> <OUTPUT_FILE> [OPTIONAL_HEADERS]"
  exit 1
fi

# Parameters
ACCESS_TOKEN=$1
SIGNING_KEY_NAME=$2
RELEASE_BUNDLE_VERSION=$3
BUILD_NAME=$4
BUILD_NUMBER=$5

OPTIONAL_HEADERS=$3

curl --request POST \
  --url 'https://tomjfrog.jfrog.io/lifecycle/api/v2/release_bundle?project=default&async=true' \
  --header 'Authorization: Bearer $ACCESS_TOKEN' \
  --header 'Content-Type: application/json' \
  --header 'X-JFrog-Signing-Key-Name: $SIGNING_KEY_NAME' \
  --data '{
    "release_bundle_name": "rlm-intro-bundle",
    "release_bundle_version": "$RELEASE_BUNDLE_VERSION",
    "source_type": "builds",
    "source": {
        "builds": [
            {
                "build_repository": "artifactory-build-info",
                "build_name": "$BUILD_NAME",
                "build_number": "$BUILD_NUMBER",
                "include_dependencies": false
            }
        ]
    }
}
'