#!/bin/bash

TAG_VERSION=$1
DES=$2
BRANCH=$(git rev-parse --abbrev-ref HEAD)
REPO_FULL_NAME=$(git config --get remote.origin.url)
re='(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+).git$'

if [[ "$REPO_FULL_NAME" =~ $re ]];
then

Personal_Access_Token="Your Github Token"
OWNER="${BASH_REMATCH[4]}"
REPO="${BASH_REMATCH[5]}"
fi

generate_post_data()
{
  cat <<EOF
{
  "tag_name": "$TAG_VERSION",
  "target_commitish": "$BRANCH",
  "name": "$TAG_VERSION",
  "body": "$DES",
  "draft": false,
  "prerelease": false,
  "generate_release_notes":false
}
EOF
}

curl \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  "https://$Personal_Access_Token@api.github.com/repos/$OWNER/$REPO/releases" \
  -d "$(generate_post_data)"

echo "Your Releases URL: https://$Personal_Access_Token@api.github.com/repos/$OWNER/$REPO/releases"
echo "Create release $VERSION for repo: $REPO branch: $BRANCH tag:$VERSION $description: $DES"