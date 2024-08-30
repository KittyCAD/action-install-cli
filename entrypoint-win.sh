#!/bin/sh
set -e

# Export the sha256sum for verification.
mkdir "C:\Program Files\Zoo"
if [ ! $? -eq 0 ]; then exit $?; fi

# Add path for this shell to test cli
export PATH=$PATH:"/C/Program Files/Zoo"

# Add to Github path for later shells
echo "C:\Program Files\Zoo" >> $GITHUB_PATH

# The latest release
RELEASE=$(curl "https://api.github.com/repos/KittyCAD/cli/releases" | jq -r ".[0].name")
if [ ! $? -eq 0 ]; then exit $?; fi

# Get the SHA256 hash of the latest release
KITTYCAD_CLI_SHA256=$(curl -L -f "https://github.com/KittyCAD/cli/releases/download/$RELEASE/zoo-x86_64-pc-windows-gnu.sha256" | cut -d ' ' -f 1)
if [ ! $? -eq 0 ]; then exit $?; fi

# Download and check the sha256sum.
curl -fSL "https://github.com/KittyCAD/cli/releases/download/$RELEASE/zoo-x86_64-pc-windows-gnu" -o "C:\Program Files\Zoo\zoo.exe" \
	&& echo "${KITTYCAD_CLI_SHA256}  C:\Program Files\Zoo\zoo.exe" | sha256sum -c - \
	&& chmod a+x "C:\Program Files\Zoo\zoo.exe"
if [ ! $? -eq 0 ]; then exit $?; fi

echo "zoo cli installed!"

# Run it!
zoo -h

