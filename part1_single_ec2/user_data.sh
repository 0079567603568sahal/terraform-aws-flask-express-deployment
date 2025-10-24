#!/bin/bash
set -xe

# update and install basics
apt-get update -y
apt-get upgrade -y
apt-get install -y python3 python3-pip curl git

# install Node.js 18.x
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs build-essential

# install pm2 to manage node
npm install -g pm2

# create app directories
mkdir -p /opt/apps/flask
mkdir -p /opt/apps/express

# create sample flask app
cat > /opt/apps/flask/app.py <<'PY'
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello from Flask on port 5000'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
PY

cat > /opt/apps/flask/requirements.txt <<'REQ'
Flask==2.2.5
REQ

# create sample express app
cat > /opt/apps/express/index.js <<'JS'
const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => res.send('Hello from Express on port 3000'))

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

# install dependencies
pip3 install -r /opt/apps/flask/requirements.txt
cd /opt/apps/express && npm install --production

# start flask (nohup so it survives)
nohup python3 /opt/apps/flask/app.py > /var/log/flask.log 2>&1 &

# start express with pm2
pm2 start /opt/apps/express/index.js --name express-app
pm2 save
pm2 startup systemd -u root --hp /root || true
