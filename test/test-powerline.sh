#!/bin/bash

# Test script for powerline symbol rendering in Konsole

echo "Testing powerline symbol rendering..."
echo ""

# Test basic powerline symbols
echo -e "Powerline symbols test:"
echo -e "\uE0B0 \uE0B1 \uE0B2 \uE0B3"
echo -e "\uE0B4 \uE0B5 \uE0B6 \uE0B7"
echo -e "\uE0B8 \uE0B9 \uE0BA \uE0BB"
echo -e "\uE0BC \uE0BD \uE0BE \uE0BF"
echo ""

# Test colored segments (similar to what Oh-My-Posh would render)
echo "Colored segments test:"
echo -e "\033[48;2;227;11;92m\033[38;2;31;13;36m User \033[0m\033[38;2;227;11;92m\uE0B0\033[0m\033[48;2;194;30;86m\033[38;2;255;255;255m Path \033[0m\033[38;2;194;30;86m\uE0B0\033[0m\033[48;2;139;34;82m\033[38;2;255;255;255m Git \033[0m\033[38;2;139;34;82m\uE0B0\033[0m"
echo ""

echo "If symbols display correctly and colors match the RGX palette, powerline is properly configured!"