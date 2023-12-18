# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="389bb6475dc487437eb38d842a8acd70df9e97107afe82ed144e633597f7178a"


# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.2.16/kittycad-x86_64-unknown-linux-musl" -o "/usr/local/bin/kittycad" \
	&& echo "${KITTYCAD_CLI_SHA256}  /usr/local/bin/kittycad" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/kittycad"

echo "kittycad cli installed!"

# Run it!
kittycad -h
