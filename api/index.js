const express = require('express')
const compression = require('compression')
const helmet = require('helmet')
const app = express()
const dotenv = require('dotenv')
const pool = require('./database/connector')
dotenv.config()

const port = process.env.APPLICATION_PORT

app.use(helmet())

app.use(compression())

app.use(express.json({ limit: '1mb' }))

app.get('/health', async (req, res) => {
  try {
    await pool.query('SELECT 1')
    res.status(200).json({
      status: 'healthy',
      database: 'connected',
      uptime: process.uptime(),
      timestamp: new Date().toISOString()
    })
  } catch (error) {
    res.status(503).json({
      status: 'unhealthy',
      database: 'disconnected',
      error: error.message
    })
  }
})

const alertsRoutes = require('./routes/alerts')
const companyRoutes = require('./routes/company')
const historyRoutes = require('./routes/history')
const ruleRoutes = require('./routes/rule')

app.use('/alerts', alertsRoutes)
app.use('/company', companyRoutes)
app.use('/history', historyRoutes)
app.use('/rule', ruleRoutes)

app.listen(port, () => console.log(`App listening on port ${port}`))
