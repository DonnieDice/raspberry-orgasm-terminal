# Contributing to Raspberry Orgasm Terminal Theme

First off, thank you for considering contributing to this project! 🍓

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- Your Windows version
- Windows Terminal version
- PowerShell version
- Clear description of the issue
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable

### Suggesting Enhancements

Enhancement suggestions are welcome! Please provide:

- Clear use case
- Detailed explanation of the feature
- Mockups or examples if applicable
- Why this would benefit other users

### Pull Requests

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Setup

1. Clone your fork:
   ```powershell
   git clone https://github.com/your-username/raspberry-orgasm-terminal.git
   cd raspberry-orgasm-terminal
   ```

2. Test your changes:
   ```powershell
   # Test the installer
   .\install.ps1 -Force
   
   # Manually test configurations
   Copy-Item config\* -Destination $env:USERPROFILE\test-config\ -Recurse
   ```

### Code Style Guidelines

- Follow PowerShell best practices
- Use clear, descriptive variable names
- Comment complex logic
- Test on multiple Windows versions
- Maintain backwards compatibility

### Security Guidelines

- Never include API keys or secrets
- Maintain security and privacy features
- Keep all processing local
- Document security implications

### Testing

Before submitting:

1. Test fresh installation
2. Test upgrade from existing setup
3. Verify all hotkeys work
4. Check all tool integrations
5. Ensure colors render correctly

### Documentation

- Update README.md for new features
- Add examples for new functionality
- Update troubleshooting if needed
- Document breaking changes

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Welcome newcomers
- Accept constructive criticism
- Focus on what's best for the community
- Show empathy towards others

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Public or private harassment
- Publishing private information
- Other unprofessional conduct

## Recognition

Contributors will be recognized in:
- The project README
- Release notes
- Special thanks section

## Questions?

Feel free to open an issue for any questions about contributing!

---

Thank you for helping make this terminal theme even better! 🚀