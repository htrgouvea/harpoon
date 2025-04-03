const express = require('express')
const router = express.Router()

router.get('/', (request, response) => {
  response.send('Hello World History')
})

router.get('/:id', (request, response) => {
  response.send('Hello World History')
})

router.post('/', (request, response) => {
  response.send('Hello World History')
})

router.put('/:id', (request, response) => {
  response.send('Hello World History')
})

router.delete('/:id', (request, response) => {
  response.send('Hello World History')
})

module.exports = router;
