# Konsole Powerline Setup Verification

This document explains how to verify that the Raspberry Orgasm Terminal Theme is properly configured for powerline symbols in Konsole.

## Verification Steps

1. **Run the verification script**:
   ```bash
   ./test/verify-konsole-powerline.sh
   ```

2. **Check the visual output**:
   - Powerline symbols should display without gaps or question marks
   - Colors should match the RGX palette:
     - Background: Deep Purple-Black (#1f0d24)
     - RGX Red: Primary Accent (#e30b5c)
     - Cranberry: Secondary Accent (#c21e56)
     - Deep Pink: Tertiary Accent (#8b2252)
     - Purple-Grey: Final Accent (#9d7ba8)

3. **Manual verification in Konsole**:
   - Open Konsole
   - Go to Settings → Edit Current Profile → Appearance
   - Ensure "RGX Raspberry" is selected as the profile
   - Ensure "Raspberry Orgasm" is selected as the color scheme
   - Go to Settings → Edit Current Profile → Appearance → Font
   - Ensure a powerline-capable font is selected (Cascadia Code recommended)

## Troubleshooting

### Powerline Symbols Not Displaying
1. Check that Cascadia Code or another powerline-capable font is installed:
   ```bash
   fc-list | grep -i "Cascadia"
   ```
2. If not installed, run the installer again:
   ```bash
   ./install.sh
   ```

### Colors Not Displaying Correctly
1. Verify the color scheme is properly applied in Konsole settings
2. Check that the TERM environment variable is set to xterm-256color:
   ```bash
   echo $TERM
   ```
3. If not set correctly, restart Konsole or check the profile configuration

### Oh-My-Posh Prompt Issues
1. Verify that oh-my-posh is properly installed:
   ```bash
   which oh-my-posh
   ```
2. Check that the RGX theme is correctly configured in your .bashrc:
   ```bash
   grep -A 2 "oh-my-posh init bash" ~/.bashrc
   ```

## Expected Output

When everything is properly configured, your prompt should look similar to:

```
 hpl  ~/raspberry-orgasm-terminal  main  > 
```

With each segment having a distinct background color from the RGX palette and smooth powerline transitions between segments.