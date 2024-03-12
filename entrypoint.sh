# The latest release
RELEASE=$(curl "https://api.github.com/repos/KittyCAD/cli/tags" | jq -r ".[0].name")

# Get the SHA256 hash of the latest release
KITTYCAD_CLI_SHA256=$(curl -L "https://github.com/KittyCAD/cli/releases/download/$RELEASE/zoo-x86_64-unknown-linux-musl.sha256" | cut -d ' ' -f 1)

# Download and check the sha256sum.
curl -fSL "https://dl.zoo.dev/releases/cli/$RELEASE/zoo-x86_64-unknown-linux-musl" -o "/usr/local/bin/zoo" \
	&& echo "${KITTYCAD_CLI_SHA256} /usr/local/bin/zoo" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/zoo"

echo "zoo cli installed!"

# Run it!
zoo -h
