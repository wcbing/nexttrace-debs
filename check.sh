#!/bin/sh

REPO="nxtrace/NTrace-core"
LOCAL_REPO="wcbing-build/nexttrace-debs"

get_github_latest_tag() {
    curl -sI "https://github.com/$1/releases/latest" | grep "releases/tag" |
        sed -E 's#.*/releases/tag/[vV]*([^_\r]*).*#\1#'
}

LOCAL_VERSION=$(get_github_latest_tag "$LOCAL_REPO")
if [ -z "$LOCAL_VERSION" ]; then
    echo "Error: Can't get version tag from $LOCAL_REPO."
    LOCAL_VERSION="0"
fi

VERSION=$(get_github_latest_tag "$REPO")
if [ -z "$VERSION" ]; then
    echo "Error: Can't get version tag from $REPO."
    echo 0 > tag
    exit 1
elif [ "$LOCAL_VERSION" = "$VERSION" ]; then
    echo "No update."
    echo 0 > tag
    exit 0
fi

echo "$VERSION" > tag
echo "Update to $VERSION from $LOCAL_VERSION."
