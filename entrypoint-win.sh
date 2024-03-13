# Export the sha256sum for verification.
mkdir "C:\Program Files\Zoo"

# Add path for this shell to test cli
export PATH=$PATH:"/C/Program Files/Zoo"

# Add to Github path for later shells
echo "C:\Program Files\Zoo" >> $GITHUB_PATH

# The latest release
RELEASE=$(curl "https://api.github.com/repos/KittyCAD/cli/tags" | jq -r ".[0].name")

# Get the SHA256 hash of the latest release
KITTYCAD_CLI_SHA256=$(curl -L "https://github.com/KittyCAD/cli/releases/download/$RELEASE/zoo-x86_64-pc-windows-gnu.sha256" | cut -d ' ' -f 1)

# Download and check the sha256sum.
curl -fSL "https://dl.zoo.dev/releases/cli/$RELEASE/zoo-x86_64-pc-windows-gnu" -o "C:\Program Files\Zoo\zoo.exe" \
	&& echo "${KITTYCAD_CLI_SHA256}  C:\Program Files\Zoo\zoo.exe" | sha256sum -c - \
	&& chmod a+x "C:\Program Files\Zoo\zoo.exe"

echo "zoo cli installed!"

# Run it!
zoo -h

