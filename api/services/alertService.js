const alertRepository = require('../repositories/alertRepository')

class AlertService {
  async getAll(limit, offset) {
    return await alertRepository.findAll(limit, offset)
  }

  async getById(id) {
    return await alertRepository.findById(id)
  }

  async create(data) {
    return await alertRepository.create(data)
  }

  async update(id, data) {
    return await alertRepository.update(id, data)
  }

  async delete(id) {
    return await alertRepository.delete(id)
  }
}

module.exports = new AlertService()
