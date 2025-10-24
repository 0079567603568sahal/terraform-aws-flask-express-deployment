const express = require('express');
const fetch = require('node-fetch'); // install this: npm install node-fetch
const app = express();
const port = 3000;

// Flask backend endpoint
const FLASK_API = 'http://13.201.29.55:5000';

app.get('/', (req, res) => res.send('Hello from Express App on port 3000'));
app.get('/health', (req, res) => res.send('OK'));

// New route: calls Flask backend
app.get('/api/flask', async (req, res) => {
  try {
    const response = await fetch(`${FLASK_API}/`);
    const data = await response.json();
    res.json({
      source: 'Express App',
      flask_response: data
    });
  } catch (err) {
    console.error('Error connecting to Flask:', err);
    res.status(500).json({ error: 'Failed to reach Flask backend' });
  }
});

app.listen(port, '0.0.0.0', () =>
  console.log(`Express app listening on port ${port}`)
);
