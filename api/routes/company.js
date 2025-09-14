const express = require('express')
const router = express.Router()

router.get('/', (request, response) => {
  response.send('Hello World Company')
})

router.get('/:id', (request, response) => {
  response.send('Hello World Company')
})

router.post('/', (request, response) => {
  response.send('Hello World Company')
})

router.put('/:id', (request, response) => {
  response.send('Hello World Company')
})

router.delete('/:id', (request, response) => {
  response.send('Hello World Company')
})

module.exports = router;
