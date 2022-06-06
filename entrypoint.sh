# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="ecb8310fdb91ea44e545a19d88ebbc3c391835bc00978679030746bcb85c5031"


# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.0.9/cli-linux-amd64" -o "/usr/local/bin/kittycad" \
	&& echo "${KITTYCAD_CLI_SHA256}  /usr/local/bin/kittycad" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/kittycad"

echo "kittycad cli installed!"

# Run it!
kittycad -h
