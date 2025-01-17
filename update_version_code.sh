#!/bin/bash
set -e

PROJECT_NAME=$1
GITHUB_TOKEN=$2

if [ -z "$PROJECT_NAME" ]; then
  echo "Project name is required"
  exit 1
fi

if [ -z "$GITHUB_TOKEN" ]; then
  echo "GITHUB_TOKEN is required"
  exit 1
fi

BUILD_GRADLE_FILE="$PROJECT_NAME/build.gradle"

if [ ! -f "$BUILD_GRADLE_FILE" ]; then
  echo "build.gradle file not found in $PROJECT_NAME directory"
  exit 1
fi

# Extract the old version code
OLD_VERSION_CODE=$(grep 'versionCode' "$BUILD_GRADLE_FILE" | awk '{print $2}')
echo "Old version code: ${OLD_VERSION_CODE}"

# Calculate the new version code
NEW_VERSION_CODE=$((OLD_VERSION_CODE + 1))
echo "New version code: ${NEW_VERSION_CODE}"

# Update the build.gradle file with the new version code
sed -i "s/versionCode ${OLD_VERSION_CODE}/versionCode ${NEW_VERSION_CODE}/" "$BUILD_GRADLE_FILE"
echo "Updated version code in $BUILD_GRADLE_FILE"

# Commit and push the new version code
git add "$BUILD_GRADLE_FILE"
git commit -m "Bump version code to ${NEW_VERSION_CODE}"

# Use the GITHUB_TOKEN for authentication
REPO_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git push "${REPO_URL}"

# Export the new version code as an environment variable
echo "new_version_code=${NEW_VERSION_CODE}" >> $GITHUB_ENV