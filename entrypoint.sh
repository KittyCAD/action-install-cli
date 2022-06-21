# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="5bd98de5e17086a6ee3655842df3e8126c74c1acde416c7ae98ca9b5c2581fdb"


# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.1.1/kittycad-x86_64-pc-windows-gnu" -o "/usr/local/bin/kittycad" \
	&& echo "${KITTYCAD_CLI_SHA256}  /usr/local/bin/kittycad" | sha256sum -c - \
	&& chmod a+x "/usr/local/bin/kittycad"

echo "kittycad cli installed!"

# Run it!
kittycad -h
