const express = require('express')
const router = express.Router()
const historyService = require('../services/historyService')

router.get('/', async (request, response) => {
  try {
    const hasPagination = request.query.page !== undefined || request.query.limit !== undefined
    let limit = null
    if (hasPagination) {
      const parsedLimit = parseInt(request.query.limit)
      limit = parsedLimit || 100
    }
    const page = parseInt(request.query.page) || 0
    const offset = page * (limit || 0)

    const history = await historyService.getAll(limit, offset)

    if (hasPagination) {
      response.status(200).json({
        data: history,
        pagination: { page, limit, total: history.length }
      })
      return
    }

    response.status(200).json(history)
  } catch (error) {
    console.error('Error fetching history records:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.get('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const record = await historyService.getById(id)

    if (!record) {
      return response.status(404).json({ error: 'History record not found' })
    }

    response.status(200).json(record)
  } catch (error) {
    console.error('Error fetching history record:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.post('/', async (request, response) => {
  try {
    const { id_company, source, status } = request.body

    if (!id_company || status === undefined) {
      return response.status(400).json({
        error: 'Missing required fields: id_company, status'
      })
    }

    const record = await historyService.create({ id_company, source, status })
    response.status(201).json(record)
  } catch (error) {
    console.error('Error creating history record:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.put('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const { id_company, source, datetime, status } = request.body

    if (!id_company || status === undefined) {
      return response.status(400).json({
        error: 'Missing required fields: id_company, status'
      })
    }

    const record = await historyService.update(id, { id_company, source, datetime, status })

    if (!record) {
      return response.status(404).json({ error: 'History record not found' })
    }

    response.status(200).json(record)
  } catch (error) {
    console.error('Error updating history record:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.delete('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const record = await historyService.delete(id)

    if (!record) {
      return response.status(404).json({ error: 'History record not found' })
    }

    response.status(200).json({ message: 'History record deleted successfully', history: record })
  } catch (error) {
    console.error('Error deleting history record:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

module.exports = router;
