const express = require('express')
const app = express()
const dotenv = require('dotenv')
dotenv.config()

const port = process.env.APPLICATION_PORT || 3000

app.use(express.json())

const alertsRoutes = require('./routes/alerts')
const companyRoutes = require('./routes/company')
const historyRoutes = require('./routes/history')
const ruleRoutes = require('./routes/rule')

app.use('/alerts', alertsRoutes)
app.use('/company', companyRoutes)
app.use('/history', historyRoutes)
app.use('/rule', ruleRoutes)

app.listen(port, () => console.log(`App listening on port ${port}`))
