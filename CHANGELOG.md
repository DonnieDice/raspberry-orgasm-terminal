# Changelog

## [Unreleased]
### Fixed
- The `install.sh` script now supports a wider range of Linux distributions by detecting the package manager (`apt`, `yum`, or `pacman`).
- The `install.sh` script now correctly installs `powerline-fonts` and other necessary dependencies (`curl`, `unzip`, `lsd`, `bat`, `ripgrep`) across all supported Linux distributions.
- The `install.sh` script now uses the official `oh-my-posh` installer, ensuring a reliable installation across all supported Linux distributions.
- The `install.sh` script now includes a robust sudo privilege check at the beginning of the main installation logic, preventing hangs and providing clearer instructions if privileges are not readily available.

### Changed
- `index.js` has been significantly modified to dynamically fetch and execute the latest `install.sh` script directly from GitHub's raw content URL at runtime. This bypasses `npm`/`npx` caching mechanisms to ensure the most up-to-date installation logic is always used.
- Project version incremented to `1.2.6` in `package.json` to force `npm`/`npx` to fetch latest content.

