const express = require('express')
const router = express.Router()

router.get('/', (request, response) => {
  response.send('Hello World Rule')
})

router.get('/:id', (request, response) => {
  response.send('Hello World Rule')
})

router.post('/', (request, response) => {
  response.send('Hello World Rule')
})

router.put('/:id', (request, response) => {
  response.send('Hello World Rule')
})

router.delete('/:id', (request, response) => {
  response.send('Hello World Rule')
})

module.exports = router;
