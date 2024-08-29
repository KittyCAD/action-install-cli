#!/bin/sh

# This does not cover captured subshells.
set -e

# The latest release
RELEASE_JSON=$(curl "https://api.github.com/repos/KittyCAD/cli/releases")
if [ ! $? -eq 0 ]; then exit $?; fi

RELEASE=$(echo "$RELEASE_JSON" | jq -r ".[0].name")
if [ ! $? -eq 0 ]; then exit $?; fi

# Get the SHA256 hash of the latest release
KITTYCAD_CLI_SHA256=$(curl -L -f "https://github.com/KittyCAD/cli/releases/download/$RELEASE/zoo-x86_64-unknown-linux-musl.sha256" | cut -d ' ' -f 1)
if [ ! $? -eq 0 ]; then exit $?; fi

# Download and check the sha256sum.
curl -fSL "https://github.com/KittyCAD/cli/releases/download/$RELEASE/zoo-x86_64-unknown-linux-musl" -o "/usr/local/bin/zoo" \
	&& echo "${KITTYCAD_CLI_SHA256} /usr/local/bin/zoo" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/zoo"
if [ ! $? -eq 0 ]; then exit $?; fi

echo "zoo cli installed!"

# Run it!
zoo -h
