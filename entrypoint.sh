# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="c2927b936b0ee39414f65a0c73ef8c7dbd8a80e434e991fdffc29ab143b64238"


# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.2.12/kittycad-x86_64-unknown-linux-musl" -o "/usr/local/bin/kittycad" \
	&& echo "${KITTYCAD_CLI_SHA256}  /usr/local/bin/kittycad" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/kittycad"

echo "kittycad cli installed!"

# Run it!
kittycad -h
