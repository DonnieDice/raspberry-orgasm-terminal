# Changelog

## [Unreleased]
### Added
- Created `install-linux.sh` as a dedicated and robust Linux installation script.

### Fixed
- The `install.sh` script now supports a wider range of Linux distributions by detecting the package manager (`apt`, `yum`, or `pacman`).
- The script now correctly installs `powerline-fonts` and other necessary dependencies (`curl`, `unzip`, `lsd`, `bat`, `ripgrep`) across all supported Linux distributions.
- The `install.sh` script now uses the official `oh-my-posh` installer, ensuring a reliable installation across all supported Linux distributions.

### Changed
- The `install.sh` script has been refactored to be more robust and easier to maintain.
- `index.js` has been modified to execute `install-linux.sh` for Linux and Darwin platforms.
