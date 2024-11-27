#!/bin/bash

if [ $# -lt 8 ]; then
  echo "Usage: $0 <RT_TOKEN> <SIGNING_KEY_NAME> <BUNDLE_NAME> <SOURCE_ENVIRONMENT>"
  exit 1
fi

RT_TOKEN=$1
SIGNING_KEY_NAME=$2
RELEASE_BUNDLE_NAME=$3
RELEASE_BUNDLE_VERSION=$4
EC1_BUILD_NAME=$5
EC2_BUILD_NAME=$6
EC1_BUILD_NUMBER=$7
EC2_BUILD_NUMBER=$8

payload=$(cat <<EOF
{
  "release_bundle_name": "$RELEASE_BUNDLE_NAME",
  "release_bundle_version": "$RELEASE_BUNDLE_VERSION",
  "source_type": "builds",
  "source": {
      "builds": [
          {
              "build_repository": "artifactory-build-info",
              "build_name": "$EC1_BUILD_NAME",
              "build_number": "$EC1_BUILD_NUMBER",
              "include_dependencies": false
          },
          {
              "build_repository": "artifactory-build-info",
              "build_name": "$EC2_BUILD_NAME",
              "build_number": "$EC2_BUILD_NUMBER",
              "include_dependencies": false
          }
      ]
  }
}
EOF
)

curl --request POST \
  --user $RT_TOKEN \
  --url 'https://tomjfrog.jfrog.io/lifecycle/api/v2/release_bundle?project=default&async=false' \
  --header "Content-Type: application/json" \
  --header "X-JFrog-Signing-Key-Name: $SIGNING_KEY_NAME" \
  --data "$payload"