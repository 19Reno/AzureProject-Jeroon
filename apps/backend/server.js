const express = require('express');
const app = express();

app.get('/health', (req, res) => res.json({ status: 'ok', service: 'shopflow-backend' }));
app.get('/api/products', (req, res) => res.json([
  { id: 1, name: 'Product A', price: 100 },
  { id: 2, name: 'Product B', price: 200 }
]));

app.listen(3000, () => console.log('Backend running on port 3000'));
