# Export the sha256sum for verification.
export KITTYCAD_CLI_SHA256="1159837f9b759a6bc60c997f78f355f0f3c84cb76e42397bbd79b2422fa7314e"

mkdir "C:\Program Files\KittyCAD"

# Download and check the sha256sum.
curl -fSL "https://dl.kittycad.io/releases/cli/v0.2.12/kittycad-x86_64-pc-windows-gnu" -o "C:\Program Files\KittyCAD\kittycad.exe" \
	&& echo "${KITTYCAD_CLI_SHA256}  C:\Program Files\KittyCAD\kittycad.exe" | sha256sum -c - \
	&& chmod a+x "C:\Program Files\KittyCAD\kittycad.exe"

echo "kittycad cli installed!"

# Add path for this shell to test cli
export PATH=$PATH:"/C/Program Files/KittyCAD"
# Run it!
kittycad -h

# Add to Github path for later shells
echo "C:\Program Files\KittyCAD" >> $GITHUB_PATH
