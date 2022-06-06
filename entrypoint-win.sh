# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="ee4a911b6814262b4e4d83c877654715a6442d401dbd2a104ebf31e82101e024"

mkdir "C:\Program Files\KittyCAD"

# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.0.9/cli-windows-amd64" -o "C:\Program Files\KittyCAD\kittycad.exe" \
	&& echo "${KITTYCAD_CLI_SHA256}  C:\Program Files\KittyCAD\kittycad.exe" | sha256sum -c - \
	&& chmod a+x "C:\Program Files\KittyCAD\kittycad.exe"

echo "kittycad cli installed!"

# Add path for this shell to test cli
export PATH=$PATH:"/C/Program Files/KittyCAD"
# Run it!
kittycad -h

# Add to Github path for later shells
echo "C:\Program Files\KittyCAD" >> $GITHUB_PATH
