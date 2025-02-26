/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ 766:
/***/ ((module) => {

module.exports = eval("require")("@actions/core");


/***/ }),

/***/ 686:
/***/ ((module) => {

module.exports = eval("require")("node-fetch");


/***/ }),

/***/ 317:
/***/ ((module) => {

"use strict";
module.exports = require("child_process");

/***/ }),

/***/ 982:
/***/ ((module) => {

"use strict";
module.exports = require("crypto");

/***/ }),

/***/ 896:
/***/ ((module) => {

"use strict";
module.exports = require("fs");

/***/ }),

/***/ 857:
/***/ ((module) => {

"use strict";
module.exports = require("os");

/***/ }),

/***/ 928:
/***/ ((module) => {

"use strict";
module.exports = require("path");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __nccwpck_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		var threw = true;
/******/ 		try {
/******/ 			__webpack_modules__[moduleId](module, module.exports, __nccwpck_require__);
/******/ 			threw = false;
/******/ 		} finally {
/******/ 			if(threw) delete __webpack_module_cache__[moduleId];
/******/ 		}
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/compat */
/******/ 	
/******/ 	if (typeof __nccwpck_require__ !== 'undefined') __nccwpck_require__.ab = __dirname + "/";
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
const core = __nccwpck_require__(766);
const { promises: fsPromises } = __nccwpck_require__(896);
const fs = __nccwpck_require__(896);
const path = __nccwpck_require__(928);
const os = __nccwpck_require__(857);
const crypto = __nccwpck_require__(982);
const child_process = __nccwpck_require__(317);
const fetch = __nccwpck_require__(686);

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

module.exports = __webpack_exports__;
/******/ })()
;