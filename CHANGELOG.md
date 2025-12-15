# Changelog

## [Unreleased]
### Fixed
- The `install.sh` script now supports a wider range of Linux distributions by detecting the package manager (`apt`, `yum`, or `pacman`).
- The script now correctly installs `powerline-fonts` on Arch-based systems.
- The script now installs all necessary dependencies, including `lsd`, `bat`, and `ripgrep`.
- The `install.sh` script now uses the official `oh-my-posh` installer, ensuring a reliable installation across all supported Linux distributions.

### Changed
- The `install.sh` script has been refactored to be more robust and easier to maintain.
