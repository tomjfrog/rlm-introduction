#!/bin/bash

if [ $# -lt 8 ]; then
  echo "Usage: $0 <RT_TOKEN> <SIGNING_KEY_NAME> <BUNDLE_NAME> <SOURCE_ENVIRONMENT>"
  exit 1
fi

RT_TOKEN=$1
SIGNING_KEY_NAME=$2
RELEASE_BUNDLE_NAME=$3
RELEASE_BUNDLE_VERSION=$4
EC1_BUNDLE_NAME=$5
EC1_BUNDLE_VERSION=$6
EC2_BUNDLE_NAME=$7
EC2_BUNDLE_VERSION=$8

payload=$(cat <<EOF
{
  "release_bundle_name": "$RELEASE_BUNDLE_NAME",
  "release_bundle_version": "$RELEASE_BUNDLE_VERSION",
  "source_type": "release_bundles",
  "source": {
      "release_bundles": [
          {
              "release_bundle_name": "$EC1_BUNDLE_NAME",
              "release_bundle_version": "$EC1_BUNDLE_VERSION",
              "include_dependencies": false
          },
          {
              "release_bundle_name": "$EC2_BUNDLE_NAME",
              "release_bundle_version": "$EC2_BUNDLE_VERSION",
              "include_dependencies": false
          }
      ]
  }
}
EOF
)

curl --request POST \
  --user $RT_TOKEN \
  --url 'https://tomjfrog.jfrog.io/lifecycle/api/v2/release_bundle?async=false' \
  --header "Content-Type: application/json" \
  --header "X-JFrog-Signing-Key-Name: $SIGNING_KEY_NAME" \
  --data "$payload"