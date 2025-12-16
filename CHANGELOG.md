# Changelog

## [Unreleased]
### Fixed
- The `install.sh` script now supports a wider range of Linux distributions by detecting the package manager (`apt`, `yum`, or `pacman`).
- The `install.sh` script now correctly installs `powerline-fonts` and other necessary dependencies (`curl`, `unzip`, `lsd`, `bat`, `ripgrep`) across all supported Linux distributions.
- The `install.sh` script now uses the official `oh-my-posh` installer, ensuring a reliable installation across all supported Linux distributions.

### Changed
- `index.js` has been modified to execute `install.sh` for Linux and Darwin platforms.
- Project version incremented to `1.2.6` in `package.json` to force `npm`/`npx` to fetch latest content.

