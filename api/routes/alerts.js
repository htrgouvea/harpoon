const express = require('express')
const router = express.Router()

router.get('/', (request, response) => {
  response.send('Hello World Alerts')
})

router.get('/:id', (request, response) => {
  response.send('Hello World Alerts')
})

router.post('/', (request, response) => {
  response.send('Hello World Alerts')
})

router.put('/:id', (request, response) => {
  response.send('Hello World Alerts')
})

router.delete('/:id', (request, response) => {
  response.send('Hello World Alerts')
})

module.exports = router;
