#!/usr/bin/env node

/**
 * Validation script for Raspberry Orgasm Terminal Theme
 * Checks JSON files, script syntax, and configuration validity
 */

const fs = require('fs');
const path = require('path');

let errors = [];
let warnings = [];
let passed = 0;

// Helper function to validate JSON files
function validateJSON(filePath) {
    try {
        const content = fs.readFileSync(filePath, 'utf-8');
        JSON.parse(content);
        passed++;
        console.log(`✓ ${path.relative(process.cwd(), filePath)}`);
        return true;
    } catch (error) {
        errors.push(`✗ ${path.relative(process.cwd(), filePath)}: ${error.message}`);
        return false;
    }
}

// Helper function to find files recursively
function findFiles(dir, pattern) {
    const files = [];
    const stack = [dir];

    while (stack.length) {
        const currentDir = stack.pop();
        const entries = fs.readdirSync(currentDir, { withFileTypes: true });

        for (const entry of entries) {
            const fullPath = path.join(currentDir, entry.name);
            if (entry.isDirectory()) {
                stack.push(fullPath);
            } else if (entry.name.match(pattern)) {
                files.push(fullPath);
            }
        }
    }

    return files;
}

console.log('\n🔍 Validating Raspberry Orgasm Terminal Theme\n');

// Validate JSON files
console.log('📋 Checking JSON files...');
const jsonFiles = findFiles(process.cwd(), /\.json$/);
jsonFiles.forEach(file => validateJSON(file));

// Check for required files
console.log('\n📁 Checking required files...');
const requiredFiles = [
    'README.md',
    'package.json',
    'install.sh',
    'install.ps1',
    'config/Microsoft.PowerShell_profile.ps1',
    'config/terminal-settings-simple.json',
    'themes/rgx.omp.json'
];

requiredFiles.forEach(file => {
    const fullPath = path.join(process.cwd(), file);
    if (fs.existsSync(fullPath)) {
        passed++;
        console.log(`✓ ${file}`);
    } else {
        errors.push(`✗ Missing required file: ${file}`);
    }
});

// Check for known issues
console.log('\n⚠️  Checking for known issues...');

// Check if install.sh has set -e (error handling)
const installShPath = path.join(process.cwd(), 'install.sh');
if (fs.existsSync(installShPath)) {
    const content = fs.readFileSync(installShPath, 'utf-8');
    if (content.includes('set -e') && content.includes('set -o pipefail')) {
        passed++;
        console.log('✓ install.sh has proper error handling');
    } else {
        warnings.push('⚠ install.sh might need error handling improvements');
    }
}

// Check for unsafe character stripping in install.ps1
const installPsPath = path.join(process.cwd(), 'install.ps1');
if (fs.existsSync(installPsPath)) {
    const content = fs.readFileSync(installPsPath, 'utf-8');
    if (content.includes('[^\\x00-\\x7F]+')) {
        errors.push('✗ install.ps1 contains unsafe character stripping pattern');
    } else {
        passed++;
        console.log('✓ install.ps1 does not have unsafe character stripping');
    }
}

// Check PowerShell profile for conditional alias checks
const profilePath = path.join(process.cwd(), 'config/Microsoft.PowerShell_profile.ps1');
if (fs.existsSync(profilePath)) {
    const content = fs.readFileSync(profilePath, 'utf-8');
    const hasConditionalAliases = content.includes('Test-Path') || content.includes('Get-Command');
    if (hasConditionalAliases) {
        passed++;
        console.log('✓ PowerShell profile has conditional alias checks');
    } else {
        warnings.push('⚠ PowerShell profile might benefit from conditional alias checks');
    }
}

// Summary
console.log('\n' + '='.repeat(50));
console.log(`\n✅ Passed checks: ${passed}`);

if (warnings.length > 0) {
    console.log(`\n⚠️  Warnings (${warnings.length}):`);
    warnings.forEach(w => console.log(`  ${w}`));
}

if (errors.length > 0) {
    console.log(`\n❌ Errors (${errors.length}):`);
    errors.forEach(e => console.log(`  ${e}`));
    process.exit(1);
} else {
    console.log('\n✨ All validation checks passed!\n');
    process.exit(0);
}
