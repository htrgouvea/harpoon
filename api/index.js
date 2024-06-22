const express = require('express')
const app = express()
const port = 3000

const alertsRoutes = require('./routes/alerts')
const companyRoutes = require('./routes/company')
const historyRoutes = require('./routes/history')
const ruleRoutes = require('./routes/rule')

app.get('/', (request, response) => {
  repsonse.send('Hello World!')
})

app.use('/alerts', alertsRoutes)
app.use('/company', companyRoutes)
app.use('/history', historyRoutes)
app.use('/rule', ruleRoutes)

app.listen(port, () => console.log(`App listening on port ${port}`))
