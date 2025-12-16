#!/usr/bin/env node

const os = require('os');
const path = require('path');
const { spawn } = require('child_process');
const https = require('https');
const fs = require('fs');

const platform = os.platform();
const scriptsDir = __dirname;
const installScriptUrl = 'https://raw.githubusercontent.com/DonnieDice/raspberry-orgasm-terminal/main/install.sh';

const executeScript = (scriptPath, args = []) => {
    const child = spawn(scriptPath, args, { stdio: 'inherit' });

    child.on('close', (code) => {
        if (code !== 0) {
            console.error(`Script exited with code ${code}`);
        } else {
            console.log('\nInstallation script finished.');
            console.log('Please restart your terminal to see the changes.');
        }
        // Clean up the temporary script file if it was downloaded
        if (scriptPath.startsWith(os.tmpdir()) && fs.existsSync(scriptPath)) {
            fs.unlinkSync(scriptPath);
            console.log(`Cleaned up temporary script: ${scriptPath}`);
        }
    });

    child.on('error', (err) => {
        console.error('Failed to start script:', err);
        // Clean up the temporary script file on error too
        if (scriptPath.startsWith(os.tmpdir()) && fs.existsSync(scriptPath)) {
            fs.unlinkSync(scriptPath);
            console.log(`Cleaned up temporary script: ${scriptPath}`);
        }
    });
};

console.log(`Starting installation for ${platform}...`);

switch (platform) {
    case 'win32':
        executeScript('powershell.exe', ['-ExecutionPolicy', 'Bypass', '-File', path.join(scriptsDir, 'install.ps1')]);
        break;
    case 'linux':
    case 'darwin':
        console.log(`Downloading latest install.sh from ${installScriptUrl}...`);
        const tempScriptPath = path.join(os.tmpdir(), 'install_temp.sh');
        
        https.get(installScriptUrl, (res) => {
            if (res.statusCode !== 200) {
                console.error(`Failed to download install.sh. Status Code: ${res.statusCode}`);
                console.error('Please check your internet connection or try again later.');
                return;
            }

            const fileStream = fs.createWriteStream(tempScriptPath);
            res.pipe(fileStream);

            fileStream.on('finish', () => {
                fileStream.close(() => {
                    console.log('install.sh downloaded successfully. Executing...');
                    fs.chmodSync(tempScriptPath, '755'); // Make it executable
                    executeScript('bash', [tempScriptPath]);
                });
            });
        }).on('error', (err) => {
            console.error('Error during download:', err.message);
            console.error('Please check your internet connection or try again later.');
        });
        break;
    default:
        console.error(`Unsupported platform: ${platform}`);
        console.log('Please see the manual installation instructions in the README.');
        break;
}
