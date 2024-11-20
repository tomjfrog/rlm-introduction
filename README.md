# RLM Orientation

These two examples are REST API calls based of the Release Lifecycle Management Documentation located at
https://jfrog.com/help/r/jfrog-rest-apis/release-bundle-v2-apis

## REST API EXAMPLE CALL FOR RBv2 CREATE
```bash
curl --request POST \
--url 'https://tomjfrog.jfrog.io/lifecycle/api/v2/release_bundle?project=default&async=true' \
--header 'Authorization: Bearer <valid JFrog Access Token>' \
--header 'Content-Type: application/json' \
--header 'X-JFrog-Signing-Key-Name: tomj-gpg-key' \
--data '{
  "release_bundle_name": "rlm-intro-bundle",
  "release_bundle_version": "1",
  "source_type": "builds",
  "source": {
    "builds": [
      {
      "build_repository": "artifactory-build-info",
      "build_name": "tomjfrog/rlm-introduction",
      "build_number": "17",
      "include_dependencies": false
      }
    ]
  }
}'
```

## REST API CALL FOR RBv2 PROMOTE
```bash
curl --request POST \
  --url 'https://tomjfrog.jfrog.io/lifecycle/api/v2/promotion/records/<rbv2-name>/<rbv2-version> \
  --header 'Authorization: Bearer <valid Jfrog Access Token>' \
  --header 'Content-Type: application/json' \
  --header 'X-JFrog-Signing-Key-Name: tomj-gpg-key' \
  --data '{
	"environment": "PROD",
	"included_repository_keys": [
		"rlm-introduction-prod-local"
	],
	"overwrite_existing_artifacts": false
}'
```