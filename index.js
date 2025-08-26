#!/usr/bin/env node

const os = require('os');
const path = require('path');
const { spawn } = require('child_process');

const platform = os.platform();
const scriptsDir = __dirname;

const executeScript = (scriptPath, args = []) => {
    const child = spawn(scriptPath, args, { stdio: 'inherit' });

    child.on('close', (code) => {
        if (code !== 0) {
            console.error(`Script exited with code ${code}`);
        } else {
            console.log('\nInstallation script finished.');
            console.log('Please restart your terminal to see the changes.');
        }
    });

    child.on('error', (err) => {
        console.error('Failed to start script:', err);
    });
};

console.log(`Starting installation for ${platform}...`);

switch (platform) {
    case 'win32':
        executeScript('powershell.exe', ['-ExecutionPolicy', 'Bypass', '-File', path.join(scriptsDir, 'install.ps1')]);
        break;
    case 'linux':
    case 'darwin':
        executeScript('bash', [path.join(scriptsDir, 'install.sh')]);
        break;
    default:
        console.error(`Unsupported platform: ${platform}`);
        console.log('Please see the manual installation instructions in the README.');
        break;
}
