if [ $# -lt 7 ]; then
  echo "Usage: $0 <RT_TOKEN> <SIGNING_KEY_NAME> <BUNDLE_NAME> <BUNDLE_VERSION> <ENVIRONMENT> <INCLUDED_REPOSITORY_KEYS> OVERWRITE_EXISTING_ARTIFACTS"
  exit 1
fi


RT_TOKEN=$1
SIGNING_KEY_NAME=$2
BUNDLE_NAME=$3
BUNDLE_VERSION=$4
ENVIRONMENT=$5
INCLUDED_REPOSITORY_KEYS=$6
OVERWRITE_EXISTING_ARTIFACTS=$7

# Tshooting
echo $SIGNING_KEY_NAME
echo $BUNDLE_NAME
echo $BUNDLE_VERSION
echo $ENVIRONMENT
echo $INCLUDED_REPOSITORY_KEYS
echo $OVERWRITE_EXISTING_ARTIFACTS


payload=$(cat EOF
  {
  	"environment": "QA",
  	"included_repository_keys": [
  		$INCLUDED_REPOSITORY_KEYS
  	],
  	"overwrite_existing_artifacts": $OVERWRITE_EXISTING_ARTIFACTS
  }
EOF
)

curl --request POST \
  --user $RT_TOKEN \
  --url "https://tomjfrog.jfrog.io/lifecycle/api/v2/promotion/records/$BUNDLE_NAME/$BUNDLE_VERSION" \
  --header 'Content-Type: application/json' \
  --header "X-JFrog-Signing-Key-Name: $SIGNING_KEY_NAME" \
  --data "$payload"