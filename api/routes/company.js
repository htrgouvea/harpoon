const express = require('express')
const router = express.Router()
const companyService = require('../services/companyService')

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

    const companies = await companyService.getAll(limit, offset)

    if (hasPagination) {
      response.status(200).json({
        data: companies,
        pagination: { page, limit, total: companies.length }
      })
      return
    }

    response.status(200).json(companies)
  } catch (error) {
    console.error('Error fetching companies:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.get('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const company = await companyService.getById(id)

    if (!company) {
      return response.status(404).json({ error: 'Company not found' })
    }

    response.status(200).json(company)
  } catch (error) {
    console.error('Error fetching company:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.post('/', async (request, response) => {
  try {
    const { name, email, status } = request.body

    if (!name || !email || status === undefined) {
      return response.status(400).json({ error: 'Missing required fields: name, email, status' })
    }

    const company = await companyService.create({ name, email, status })
    response.status(201).json(company)
  } catch (error) {
    console.error('Error creating company:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.put('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const { name, email, status } = request.body

    if (!name || !email || status === undefined) {
      return response.status(400).json({ error: 'Missing required fields: name, email, status' })
    }

    const company = await companyService.update(id, { name, email, status })

    if (!company) {
      return response.status(404).json({ error: 'Company not found' })
    }

    response.status(200).json(company)
  } catch (error) {
    console.error('Error updating company:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

router.delete('/:id', async (request, response) => {
  try {
    const { id } = request.params
    const company = await companyService.delete(id)

    if (!company) {
      return response.status(404).json({ error: 'Company not found' })
    }

    response.status(200).json({ message: 'Company deleted successfully', company })
  } catch (error) {
    console.error('Error deleting company:', error)
    response.status(500).json({ error: 'Internal server error' })
  }
})

module.exports = router;
