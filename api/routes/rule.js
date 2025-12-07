const express = require('express')
const router = express.Router()
const ruleService = require('../services/ruleService')

router.get('/', async (request, response) => {
  try {
    const hasPagination = request.query.page !== undefined || request.query.limit !== undefined
    const limit = hasPagination ? parseInt(request.query.limit) || 100 : null
    const page = parseInt(request.query.page) || 0
    const offset = page * (limit || 0)

    const rules = await ruleService.getAll(limit, offset)

    if (hasPagination) {
      response.status(200).json({
        data: rules,
        pagination: { page, limit, total: rules.length }
      })
    } else {
      response.status(200).json(rules)
    }
  } catch (error) {
    console.error('Error fetching rules:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.get('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const rule = await ruleService.getById(id)

    if (!rule) {
      return response.status(404).json({ error: 'Rule not found' })
    }

    response.status(200).json(rule)
  } catch (error) {
    console.error('Error fetching rule:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.post('/', async (request, response) => {
  try {
    const { id_company, string, filter, score, description, status } = request.body

    if (!id_company || !string || !filter || !score || !description || status === undefined) {
      return response.status(400).json({
        error: 'Missing required fields: id_company, string, filter, score, description, status'
      })
    }

    const rule = await ruleService.create({ id_company, string, filter, score, description, status })
    response.status(201).json(rule)
  } catch (error) {
    console.error('Error creating rule:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.put('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const { id_company, string, filter, score, description, status } = request.body

    if (!id_company || !string || !filter || !score || !description || status === undefined) {
      return response.status(400).json({
        error: 'Missing required fields: id_company, string, filter, score, description, status'
      })
    }

    const rule = await ruleService.update(id, { id_company, string, filter, score, description, status })

    if (!rule) {
      return response.status(404).json({ error: 'Rule not found' })
    }

    response.status(200).json(rule)
  } catch (error) {
    console.error('Error updating rule:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.delete('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const rule = await ruleService.delete(id)

    if (!rule) {
      return response.status(404).json({ error: 'Rule not found' })
    }

    response.status(200).json({ message: 'Rule deleted successfully', rule })
  } catch (error) {
    console.error('Error deleting rule:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

module.exports = router;
