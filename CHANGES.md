# Changes

## v1.0.2 (December 11, 2025)
- Packaged essential Cascadia Code Nerd Fonts locally to reduce download size during installation.
- Updated `install.sh` to copy these local font files and removed external font download steps.
- Updated `uninstall.sh` to reflect the new font installation method.
- Automated setting of Konsole default profile using `kwriteconfig5` in `install.sh`, removing the manual step.
- Added cleanup for Konsole default profile in `uninstall.sh`.
- Reordered Oh My Posh initialization in `install.sh` to ensure it loads last in `.bashrc` for higher precedence.
- Updated `.bashrc` cleanup in `uninstall.sh` with more robust `sed` patterns, eliminating reliance on fixed line counts.
- Corrected font specification in `themes/konsole/rgx.profile` to 'Cascadia Mono NF' for proper symbol rendering.
- Added `command_exists` function to `uninstall.sh`.
- Removed noisy `.bashrc` sourcing from `uninstall.sh`.
- Implemented robust `.bashrc` backup in `install.sh` and restoration in `uninstall.sh` to ensure proper shell environment reversion.
- Added retry and timeout logic for `oh-my-posh` download in `install.sh`.
- Implemented a flag file in `install.sh` to track if `oh-my-posh` was installed by the script.
- Modified `uninstall.sh` to only remove `oh-my-posh` binary if installed by this script, preserving user's pre-existing installations.
- Implemented robust `sudo` handling with password prompting and retries in `install.sh` for all privileged operations.
- Added diagnostic outputs to `install.sh` for Oh My Posh debugging.

## v1.0.1 (December 11, 2025)

- Fixed Cascadia Code font download URL in `install.sh`.
- Modified `install.sh` to automatically source `.bashrc` after installation for immediate theme application.
- Added `uninstall.sh` script to cleanly remove installed components and revert changes.