# Changes

## v1.0.2 (December 11, 2025)
- Packaged essential Cascadia Code Nerd Fonts locally to reduce download size during installation.
- Updated `install.sh` to copy these local font files and removed external font download steps.
- Updated `uninstall.sh` to reflect the new font installation method.

## v1.0.1 (December 11, 2025)

- Fixed Cascadia Code font download URL in `install.sh`.
- Modified `install.sh` to automatically source `.bashrc` after installation for immediate theme application.
- Added `uninstall.sh` script to cleanly remove installed components and revert changes.