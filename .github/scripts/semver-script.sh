#!/bin/bash
#   SemVer Script
#   Uses: custom
#   From: Timothy Yolt, John Murwin

## Is used to calculate the SemVer number based of current version, and outputs version for use in Github
## NOTE: This script should only run on develop or main!

# REQUIRED files to use to update version information
VERSION_FILE="./.github/version.txt"
SONAR_FILE=""

if [ "$GITHUB_REF_NAME" == "" ]; then
  echo "Unknown Github branch name, is the SemVer.yml Workflow setup correctly?"
  exit 1
fi

# 1. Put the version info into the environment for calculation & potential manipulation
if [ -f "$VERSION_FILE" ]; then
  while IFS='=' read -r key value; do eval ${key}=${value};  done < "$VERSION_FILE"
else
  echo "Missing $VERSION_FILE"
  exit 1
fi

# 2. Store combination of values from VERSION_FILE into CURRENT_VERSION
CURRENT_VERSION="$BREAKING_VERSION.$RELEASE_VERSION.$FEATURE_VERSION"

# 3. IF NECESSARY, Grab last tag_commit_sha for comparison check before verBump


# 4. Calculate SemVer bumps based on branch names
# 4a. dev commit condition
if [ "$GITHUB_REF_NAME" == "dev" ]; then
  # create tag and push
  git tag "$CURRENT_VERSION-dev"
  git push origin "$CURRENT_VERSION-dev"

  # bump to version for next upcoming feature
  ((FEATURE_VERSION++))
fi

# 4b. main commit condition
if [ "$GITHUB_REF_NAME" == "main" ]; then
  # create tag and push
  git tag "$CURRENT_VERSION"
  git push origin "$CURRENT_VERSION"

  # bump to version for next upcoming release & set feature to 0
  ((RELEASE_VERSION++))
  PATCH_VERSION=0
fi

# 5. Version number increments only happen on dev branch
git checkout dev
git pull

# 6. Update version.txt file
sed -i "s/\(PATCH_VERSION=\).*\$/\1${PATCH_VERSION}/" $VERSION_FILE
sed -i "s/\(MINOR_VERSION=\).*\$/\1${MINOR_VERSION}/" $VERSION_FILE

# 7. Update sonar-project.properties file
# sed -i "s/\(projectVersion=\).*\$/\1${NEW_VERSION}/" $SONAR_FILE

# 8. Set new version for dev update
NEW_VERSION="$BREAKING_VERSION.$RELEASE_VERSION.$FEATURE_VERSION"

git add "$VERSION_FILE"
git commit -m "[ci skip] Automated Commit: CI Build Number Increment $CURRENT_VERSION -> $NEW_VERSION"
git push origin dev

# X. Export CURRENT_VERSION for use in Github Actions
export CURRENT_VERSION