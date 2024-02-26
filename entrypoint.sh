# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="ae007cff66e210d407145645e13c4f0fc4ebf2071d6dadfb76938bce5da8965e"


# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.2.21/kittycad-x86_64-unknown-linux-musl" -o "/usr/local/bin/kittycad" \
	&& echo "${KITTYCAD_CLI_SHA256}  /usr/local/bin/kittycad" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/kittycad"

echo "kittycad cli installed!"

# Run it!
kittycad -h
