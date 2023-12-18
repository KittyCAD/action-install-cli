# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="8649d7977dc6b92bda1212e56ee1bfb52f230613fcf4fa227cdf3ebb37cc2368"

mkdir "C:\Program Files\KittyCAD"

# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.2.16/kittycad-x86_64-pc-windows-gnu" -o "C:\Program Files\KittyCAD\kittycad.exe" \
	&& echo "${KITTYCAD_CLI_SHA256}  C:\Program Files\KittyCAD\kittycad.exe" | sha256sum -c - \
	&& chmod a+x "C:\Program Files\KittyCAD\kittycad.exe"

echo "kittycad cli installed!"

# Add path for this shell to test cli
export PATH=$PATH:"/C/Program Files/KittyCAD"
# Run it!
kittycad -h

# Add to Github path for later shells
echo "C:\Program Files\KittyCAD" >> $GITHUB_PATH
