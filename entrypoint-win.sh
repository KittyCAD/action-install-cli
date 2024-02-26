# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="ac4b9ad2863eea0c22ef43a958d23c2c55755009d6f41e81cbe1e7c0334ed3a9"

mkdir "C:\Program Files\Zoo"

# Download and check the sha256sum.
curl -fSL "https://dl.zoo.dev/releases/cli/v0.2.21/zoo-x86_64-pc-windows-gnu" -o "C:\Program Files\Zoo\zoo.exe" \
	&& echo "${KITTYCAD_CLI_SHA256}  C:\Program Files\Zoo\zoo.exe" | sha256sum -c - \
	&& chmod a+x "C:\Program Files\Zoo\zoo.exe"

echo "zoo cli installed!"

# Add path for this shell to test cli
export PATH=$PATH:"/C/Program Files/Zoo"
# Run it!
zoo -h

# Add to Github path for later shells
echo "C:\Program Files\Zoo" >> $GITHUB_PATH
