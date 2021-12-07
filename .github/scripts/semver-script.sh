#!/bin/bash
#   SemVer Script
#   Uses: custom
#   From: Timothy Yolt, John Murwin

## Is used to calculate the SemVer number based of current version, and outputs version for use in Github
## NOTE: This script should only run on develop or main!

# required files to use to update version information
VERSION_FILE="./.github/version.txt"

VERSION=0.3.0

# put the version info into the environment
if [ -f "$VERSION_FILE" ]; then
  export VERSION
else
  echo "Missing $VERSION_FILE"
  exit 1
fi
