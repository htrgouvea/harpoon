const express = require('express')
const router = express.Router()
const alertService = require('../services/alertService')

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

    const alerts = await alertService.getAll(limit, offset)

    if (hasPagination) {
      response.status(200).json({
        data: alerts,
        pagination: { page, limit, total: alerts.length }
      })
      return
    }

    response.status(200).json(alerts)
  } catch (error) {
    console.error('Error fetching alerts:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.get('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const alert = await alertService.getById(id)

    if (!alert) {
      return response.status(404).json({ error: 'Alert not found' })
    }

    response.status(200).json(alert)
  } catch (error) {
    console.error('Error fetching alert:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.post('/', async (request, response) => {
  try {
    const { id_company, status, notification, content, hash } = request.body

    if (!id_company || status === undefined || notification === undefined || !content || !hash) {
      return response.status(400).json({
        error: 'Missing required fields: id_company, status, notification, content, hash'
      })
    }

    const alert = await alertService.create({ id_company, status, notification, content, hash })
    response.status(201).json(alert)
  } catch (error) {
    console.error('Error creating alert:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.put('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const { id_company, datetime, status, notification, content, hash } = request.body

    if (!id_company || status === undefined || notification === undefined || !content || !hash) {
      return response.status(400).json({
        error: 'Missing required fields: id_company, status, notification, content, hash'
      })
    }

    const alert = await alertService.update(id, { id_company, datetime, status, notification, content, hash })

    if (!alert) {
      return response.status(404).json({ error: 'Alert not found' })
    }

    response.status(200).json(alert)
  } catch (error) {
    console.error('Error updating alert:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.delete('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const alert = await alertService.delete(id)

    if (!alert) {
      return response.status(404).json({ error: 'Alert not found' })
    }

    response.status(200).json({ message: 'Alert deleted successfully', alert })
  } catch (error) {
    console.error('Error deleting alert:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

module.exports = router;
