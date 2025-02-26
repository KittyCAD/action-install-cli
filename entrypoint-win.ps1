# Create the install directory. The -Force flag creates the directory if it does not exist.
try {
    New-Item -ItemType Directory -Path "C:\Program Files\Zoo" -Force -ErrorAction Stop | Out-Null
} catch {
    Write-Error "Failed to create directory 'C:\Program Files\Zoo': $_"
    exit 1
}

# Add the install directory to the current session's PATH.
$env:PATH = "$env:PATH;C:\Program Files\Zoo"

# Append the install path to the GITHUB_PATH file (if the environment variable is set).
if ($env:GITHUB_PATH) {
    try {
        Add-Content -Path $env:GITHUB_PATH -Value "C:\Program Files\Zoo"
    } catch {
        Write-Error "Failed to append path to GITHUB_PATH: $_"
        exit 1
    }
}

# Retrieve the latest release name from the GitHub API.
try {
    $releaseInfo = Invoke-RestMethod "https://api.github.com/repos/KittyCAD/cli/releases"
    $RELEASE = $releaseInfo[0].name
} catch {
    Write-Error "Failed to retrieve the latest release information: $_"
    exit 1
}

# Get the expected SHA256 hash from the release.
try {
    $sha256Content = Invoke-RestMethod -Uri "https://github.com/KittyCAD/cli/releases/download/$RELEASE/zoo-x86_64-pc-windows-gnu.sha256"
    # The file content is assumed to be in the format "<hash>  <filename>".
    $KITTYCAD_CLI_SHA256 = $sha256Content.Split(" ")[0]
} catch {
    Write-Error "Failed to retrieve SHA256 hash: $_"
    exit 1
}

# Download the executable.
try {
    Invoke-WebRequest -Uri "https://github.com/KittyCAD/cli/releases/download/$RELEASE/zoo-x86_64-pc-windows-gnu" `
        -OutFile "C:\Program Files\Zoo\zoo.exe" -UseBasicParsing -ErrorAction Stop
} catch {
    Write-Error "Failed to download zoo.exe: $_"
    exit 1
}

# Verify the downloaded file's SHA256 hash.
$computedHash = (Get-FileHash "C:\Program Files\Zoo\zoo.exe" -Algorithm SHA256).Hash
if ($computedHash -ne $KITTYCAD_CLI_SHA256) {
    Write-Error "SHA256 verification failed. Expected: $KITTYCAD_CLI_SHA256, Got: $computedHash"
    exit 1
}

Write-Host "zoo cli installed!"

# Run the installed CLI with the '-h' flag to display help.
& "C:\Program Files\Zoo\zoo.exe" -h
