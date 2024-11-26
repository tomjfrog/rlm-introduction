#!/bin/bash
if [ $# -lt 6 ]; then
  echo "Usage: $0 <RT_TOKEN> <SIGNING_KEY_NAME> <RELEASE_BUNDLE_VERSION> <BUILD_NAME> <BUILD_NUMBER>"
  exit 1
fi

# Parameters
RT_TOKEN=$1
SIGNING_KEY_NAME=$2
RELEASE_BUNDLE_NAME=$3
RELEASE_BUNDLE_VERSION=$4
BUILD_NAME=$5
BUILD_NUMBER=$6

curl --request POST \
  --user $RT_TOKEN
  --url 'https://tomjfrog.jfrog.io/lifecycle/api/v2/release_bundle?project=default&async=true' \
  --header 'Content-Type: application/json' \
  --header 'X-JFrog-Signing-Key-Name: $SIGNING_KEY_NAME' \
  --data '{
    "release_bundle_name": "$RELEASE_BUNDLE_NAME",
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