#!/usr/bin/env node
const { execSync } = require('child_process');
const path = require('path');

const installScript = path.join(__dirname, 'install.sh');
try {
  execSync(`bash "${installScript}"`, { stdio: 'inherit' });
} catch (e) {
  console.warn('⚠ Skill linking skipped (this is normal during npx one-shot installs)');
}
