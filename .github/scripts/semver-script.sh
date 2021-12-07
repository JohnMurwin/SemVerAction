#!/bin/bash
#   SemVer Script
#   Uses: custom
#   From: Timothy Yolt, John Murwin

## Is used to calculate the SemVer number based of current version, and outputs version for use in Github
## NOTE: This script should only run on develop or main!

# required files to use to update version information
VERSION_FILE="./.github/version.txt"

# put the version info into the environment
if [ -f "$VERSION_FILE" ]; then
  while IFS='=' read -r key value; do eval ${key}=${value};  done < "$VERSION_FILE"
else
  echo "Missing $VERSION_FILE"
  exit 1
fi

CURRENT_VERSION="$BREAKING_VERSION.$RELEASE_VERSION.$FEATURE_VERSION"

export CURRENT_VERSION