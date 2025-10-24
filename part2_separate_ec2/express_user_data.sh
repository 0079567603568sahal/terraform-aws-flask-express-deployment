#!/bin/bash
set -xe

apt-get update -y
apt-get upgrade -y
apt-get install -y curl nodejs npm git build-essential

# install Node 18.x (safer if using deb nodesource; but older ubuntu may include nodejs)
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

npm install -g pm2

mkdir -p /opt/apps/express
cat > /opt/apps/express/index.js <<'JS'
const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => res.send('Hello from Express on port 3000'))
app.get('/health', (req, res) => res.send('OK'))

app.listen(port, '0.0.0.0', () => console.log(`Express listening on ${port}`))
JS

cat > /opt/apps/express/package.json <<'PJ'
{
  "name": "express-sample",
  "version": "1.0.0",
  "main": "index.js",
  "dependencies": {
    "express": "^4.18.2"
  }
}
PJ

cd /opt/apps/express && npm install --production
pm2 start /opt/apps/express/index.js --name express-app
pm2 save
pm2 startup systemd -u root --hp /root || true
