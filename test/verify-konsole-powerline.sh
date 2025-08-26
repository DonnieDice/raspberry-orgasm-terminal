#!/bin/bash

# Raspberry Orgasm Terminal Theme - Konsole Powerline Verification Script

echo "=== Raspberry Orgasm Terminal Theme ==="
echo "         Konsole Powerline Verification"
echo ""

# Check if we're in Konsole
if [[ "$KONSOLE_VERSION" ]]; then
    echo "✓ Running in Konsole (version $KONSOLE_VERSION)"
else
    echo "⚠ Not running in Konsole - this verification is for Konsole specifically"
fi

echo ""

# Check for required tools
echo "Checking required tools:"
if command -v oh-my-posh &> /dev/null; then
    echo "✓ oh-my-posh is installed"
else
    echo "✗ oh-my-posh is not installed"
fi

echo ""

# Check font support
echo "Checking font support:"
if fc-list | grep -i "Cascadia" > /dev/null; then
    echo "✓ Cascadia Code font is installed"
elif fc-list | grep -i "Powerline" > /dev/null; then
    echo "✓ Powerline fonts are installed"
elif fc-list | grep -i "Fira.*Mono" > /dev/null; then
    echo "✓ Fira Mono font is installed (powerline capable)"
elif fc-list | grep -i "DejaVu.*Sans.*Mono" > /dev/null; then
    echo "✓ DejaVu Sans Mono font is installed (powerline capable)"
elif fc-list | grep -i "Source.*Code.*Pro" > /dev/null; then
    echo "✓ Source Code Pro font is installed (powerline capable)"
else
    echo "⚠ No known powerline-capable font detected"
    echo "  (This may be a false negative - check manually in Konsole settings)"
fi

echo ""

# Test powerline symbols
echo "Powerline symbols test:"
echo "These symbols should display without gaps or question marks:"
echo -e "               "
echo ""

# Test colors
echo "RGX Color Palette Test:"
echo -e "\033[48;2;31;13;36m\033[38;2;255;219;233m Background \033[0m #1f0d24 (Deep Purple-Black)"
echo -e "\033[48;2;227;11;92m\033[38;2;255;255;255m RGX Red \033[0m #e30b5c (Primary Accent)"
echo -e "\033[48;2;194;30;86m\033[38;2;255;255;255m Cranberry \033[0m #c21e56 (Secondary Accent)"
echo -e "\033[48;2;139;34;82m\033[38;2;255;255;255m Deep Pink \033[0m #8b2252 (Tertiary Accent)"
echo -e "\033[48;2;157;123;168m\033[38;2;31;13;36m Purple-Grey \033[0m #9d7ba8 (Final Accent)"
echo ""

# Test Oh-My-Posh theme
echo "Oh-My-Posh Theme Test:"
if [ -f "themes/rgx.omp.json" ]; then
    echo "✓ RGX Oh-My-Posh theme file found"
    echo "  Testing theme rendering..."
    # Show what the prompt would look like
    echo -e "\033[48;2;227;11;92m\033[38;2;31;13;36m hpl \033[0m\033[38;2;227;11;92m\033[0m\033[48;2;194;30;86m\033[38;2;255;255;255m ~/raspberry-orgasm-terminal \033[0m\033[38;2;194;30;86m\033[0m\033[48;2;139;34;82m\033[38;2;255;255;255m main \033[0m\033[38;2;139;34;82m\033[0m\033[48;2;157;123;168m\033[38;2;31;13;36m > \033[0m\033[38;2;157;123;168m\033[0m"
else
    echo "✗ RGX Oh-My-Posh theme file not found"
fi

echo ""
echo "=== Verification Complete ==="
echo ""
echo "If all symbols display correctly and colors match the RGX palette,"
echo "your Konsole powerline setup is working properly!"
echo ""
echo "For any issues, please check:"
echo "1. Konsole profile is set to 'RGX Raspberry'"
echo "2. Color scheme is set to 'Raspberry Orgasm'"
echo "3. Powerline-capable font is selected (Cascadia Code recommended)"