# Export the sha256sum for verification.
export ZOO_CLI_SHA256="8649d7977dc6b92bda1212e56ee1bfb52f230613fcf4fa227cdf3ebb37cc2368"

mkdir "C:\Program Files\Zoo"

# Download and check the sha256sum.
curl -fSL "https://dl.zoo.io/releases/cli/v0.2.16/zoo-x86_64-pc-windows-gnu" -o "C:\Program Files\Zoo\zoo.exe" \
	&& echo "${ZOO_CLI_SHA256}  C:\Program Files\Zoo\zoo.exe" | sha256sum -c - \
	&& chmod a+x "C:\Program Files\Zoo\zoo.exe"

echo "zoo cli installed!"

# Add path for this shell to test cli
export PATH=$PATH:"/C/Program Files/Zoo"
# Run it!
zoo -h

# Add to Github path for later shells
echo "C:\Program Files\Zoo" >> $GITHUB_PATH
