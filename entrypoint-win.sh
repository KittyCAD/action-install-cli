# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="5bd98de5e17086a6ee3655842df3e8126c74c1acde416c7ae98ca9b5c2581fdb"

mkdir "C:\Program Files\KittyCAD"

# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.1.1/kittycad-x86_64-pc-windows-gnu" -o "C:\Program Files\KittyCAD\kittycad.exe" \
	&& echo "${KITTYCAD_CLI_SHA256}  C:\Program Files\KittyCAD\kittycad.exe" | sha256sum -c - \
	&& chmod a+x "C:\Program Files\KittyCAD\kittycad.exe"

echo "kittycad cli installed!"

# Add path for this shell to test cli
export PATH=$PATH:"/C/Program Files/KittyCAD"
# Run it!
kittycad -h

# Add to Github path for later shells
echo "C:\Program Files\KittyCAD" >> $GITHUB_PATH
