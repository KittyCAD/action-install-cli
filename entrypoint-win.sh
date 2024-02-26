# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="ac4b9ad2863eea0c22ef43a958d23c2c55755009d6f41e81cbe1e7c0334ed3a9"

mkdir "C:\Program Files\KittyCAD"

# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.2.21/kittycad-x86_64-pc-windows-gnu" -o "C:\Program Files\KittyCAD\kittycad.exe" \
	&& echo "${KITTYCAD_CLI_SHA256}  C:\Program Files\KittyCAD\kittycad.exe" | sha256sum -c - \
	&& chmod a+x "C:\Program Files\KittyCAD\kittycad.exe"

echo "kittycad cli installed!"

# Add path for this shell to test cli
export PATH=$PATH:"/C/Program Files/KittyCAD"
# Run it!
kittycad -h

# Add to Github path for later shells
echo "C:\Program Files\KittyCAD" >> $GITHUB_PATH
