# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="73df1986bb0d1c97f72a9bb79298a464872fbf1e4c097624b911d001e7a73da1"


# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.1.1/kittycad-x86_64-unknown-linux-musl" -o "/usr/local/bin/kittycad" \
	&& echo "${KITTYCAD_CLI_SHA256}  /usr/local/bin/kittycad" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/kittycad"

echo "kittycad cli installed!"

# Run it!
kittycad -h
