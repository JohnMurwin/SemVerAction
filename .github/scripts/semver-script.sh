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

# 3. IF NECCESSARY, Grab last tag_commit_sha for comparison check before verBump


# 4. Calculate SemVer bumps based on branch names

# dev commit
if [ "$GITHUB_REF_NAME" == "dev" ]; then
  echo "dev commit & tag has happened"
  export CURRENT_VERSION
fi

# main commit
if [ "$GITHUB_REF_NAME" == "main" ]; then
  echo "main commit & tag has happened"
fi

  # X. Update VERSION_FILE

  # X. Update SONAR_FILE
