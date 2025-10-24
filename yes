from flask import Flask, jsonify
app = Flask(__name__)

@app.route('/')
def home():
    return jsonify(message="Hello from Flask App on port 5000")

@app.route('/health')
def health():
    return "OK", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
