const client = require('prom-client');
const express = require('express');
const app = express();

// Create a new counter metric to track the number of requests
const counter = new client.Counter({
  name: 'my_app_requests_total',
  help: 'Total requests received',
});

// Middleware to increase the counter on each request
app.get('/', (req, res) => {
  counter.inc(); // Increment the request counter
  res.send('Hello World!');
});

// Endpoint to expose the /metrics route for Prometheus scraping
app.get('/metrics', async (req, res) => {
  res.set('Content-Type', client.register.contentType);
  res.end(await client.register.metrics()); // Expose the metrics in Prometheus format
});

// Start the Express server on port 4000 (changed from 3000)
app.listen(4000, () => {
  console.log('App is running on http://localhost:4000');
});
