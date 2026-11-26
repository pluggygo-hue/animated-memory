const express = require('express');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const stations = [
  { id: 'PG-001', name: 'ChargePoint Hub', city: 'Jabalpur', area: 'Wright Town', powerKw: 60, connector: 'CCS2', pricePerKwh: 18, status: 'available' },
  { id: 'PG-002', name: 'GreenVolt Station', city: 'Jabalpur', area: 'Napier Town', powerKw: 30, connector: 'CCS2', pricePerKwh: 16, status: 'available' },
  { id: 'PG-003', name: 'CityCharge Point', city: 'Jabalpur', area: 'Vijay Nagar', powerKw: 7.4, connector: 'Type 2', pricePerKwh: 14, status: 'busy' }
];

app.get('/api/health', (_req, res) => res.json({ ok: true, service: 'PluggyGo API', version: '1.0.0' }));
app.get('/api/stations', (_req, res) => res.json({ data: stations, source: 'demo' }));
app.get('/api/dashboard', (_req, res) => res.json({
  metrics: { stations: stations.length, available: stations.filter(s => s.status === 'available').length, sessionsToday: 0, revenueToday: 0 },
  source: 'demo'
}));

const port = process.env.PORT || 4000;
app.listen(port, () => console.log(`PluggyGo API listening on ${port}`));
