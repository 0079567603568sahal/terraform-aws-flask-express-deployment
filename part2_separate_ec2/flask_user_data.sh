#!/bin/bash
set -xe

apt-get update -y
apt-get upgrade -y
apt-get install -y python3 python3-pip git

# create flask app
mkdir -p /opt/apps/flask
cat > /opt/apps/flask/app.py <<'PY'
from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/')
def hello():
    return jsonify(message='Hello from Flask (5000)')

@app.route('/health')
def health():
    return 'OK', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
PY

cat > /opt/apps/flask/requirements.txt <<'REQ'
Flask==2.2.5
REQ

pip3 install -r /opt/apps/flask/requirements.txt

nohup python3 /opt/apps/flask/app.py > /var/log/flask.log 2>&1 &
