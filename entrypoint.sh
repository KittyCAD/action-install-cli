# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="ae007cff66e210d407145645e13c4f0fc4ebf2071d6dadfb76938bce5da8965e"


# Download and check the sha256sum.
curl -fSL "https://dl.zoo.dev/releases/cli/v0.2.21/zoo-x86_64-unknown-linux-musl" -o "/usr/local/bin/zoo" \
	&& echo "${KITTYCAD_CLI_SHA256}  /usr/local/bin/zoo" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/zoo"

echo "zoo cli installed!"

# Run it!
zoo -h
