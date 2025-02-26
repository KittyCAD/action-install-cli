const core = require('@actions/core');
const { promises: fsPromises } = require('fs');
const fs = require('fs');
const path = require('path');
const os = require('os');
const crypto = require('crypto');
const child_process = require('child_process');
const fetch = require('node-fetch');

async function run() {
  try {
    let installDir, binaryName, releaseBinaryName, binaryPath;
    if (process.platform === 'win32') {
      // Windows installation settings.
      installDir = "C:\\Program Files\\Zoo";
      binaryName = "zoo.exe";
      releaseBinaryName = "zoo-x86_64-pc-windows-gnu";
      binaryPath = path.join(installDir, binaryName);
    } else if (process.platform === 'linux') {
      // Linux installation settings.
      // We install into /usr/local/bin; ensure the runner has permissions.
      installDir = "/usr/local/bin";
      binaryName = "zoo";
      releaseBinaryName = " zoo-x86_64-unknown-linux-musl";
      binaryPath = path.join(installDir, binaryName);
    } else {
      throw new Error(`Unsupported platform: ${process.platform}`);
    }

    // Create the installation directory if it doesn't exist.
    if (!fs.existsSync(installDir)) {
      await fsPromises.mkdir(installDir, { recursive: true });
      core.info(`Created directory: ${installDir}`);
    } else {
      core.info(`Directory already exists: ${installDir}`);
    }

    // Append installDir to the GitHub PATH if GITHUB_PATH is defined.
    if (process.env.GITHUB_PATH) {
      await fsPromises.appendFile(process.env.GITHUB_PATH, `${installDir}${os.EOL}`);
      core.info(`Appended ${installDir} to GITHUB_PATH`);
    }

    // Fetch latest release info from GitHub.
    const releasesResponse = await fetch("https://api.github.com/repos/KittyCAD/cli/releases");
    if (!releasesResponse.ok) {
      throw new Error(`Failed to fetch releases: ${releasesResponse.status} ${releasesResponse.statusText}`);
    }
    const releases = await releasesResponse.json();
    if (!Array.isArray(releases) || releases.length === 0) {
      throw new Error("No releases found.");
    }
    const release = releases[0].name;
    core.info(`Latest release: ${release}`);

    // Construct download URLs.
    const downloadUrl = `https://github.com/KittyCAD/cli/releases/download/${release}/${releaseBinaryName}`;
    const sha256Url = `${downloadUrl}.sha256`;

    // Fetch expected SHA256 hash.
    const sha256Response = await fetch(sha256Url);
    if (!sha256Response.ok) {
      throw new Error(`Failed to fetch SHA256 file: ${sha256Response.status} ${sha256Response.statusText}`);
    }
    const sha256Text = await sha256Response.text();
    const expectedHash = sha256Text.split(' ')[0].trim();
    core.info(`Expected SHA256: ${expectedHash}`);

    // Download the binary.
    const binaryResponse = await fetch(downloadUrl);
    if (!binaryResponse.ok) {
      throw new Error(`Failed to download binary: ${binaryResponse.status} ${binaryResponse.statusText}`);
    }
    const buffer = await binaryResponse.buffer();
    await fsPromises.writeFile(binaryPath, buffer);
    core.info(`Downloaded binary to ${binaryPath}`);

    // Verify the downloaded file's SHA256 hash.
    const computedHash = crypto.createHash('sha256').update(buffer).digest('hex');
    if (computedHash !== expectedHash) {
      throw new Error(`SHA256 mismatch. Expected ${expectedHash}, got ${computedHash}`);
    }
    core.info("SHA256 hash verified.");

    // On Linux, set the binary as executable.
    if (process.platform !== 'win32') {
      await fsPromises.chmod(binaryPath, 0o755);
      core.info(`Set executable permission on ${binaryPath}`);
    }

    // Run the installed binary with '--version' to capture its version.
    const versionOutput = child_process.execFileSync(binaryPath, ['--version'], { encoding: 'utf8' });
    core.info(`Zoo CLI version: ${versionOutput.trim()}`);

    // Set the output for this action.
    core.setOutput('version', versionOutput.trim());
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
