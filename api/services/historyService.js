const historyRepository = require('../repositories/historyRepository')

class HistoryService {
  async getAll(limit, offset) {
    return await historyRepository.findAll(limit, offset)
  }

  async getById(id) {
    return await historyRepository.findById(id)
  }

  async create(data) {
    return await historyRepository.create(data)
  }

  async update(id, data) {
    return await historyRepository.update(id, data)
  }

  async delete(id) {
    return await historyRepository.delete(id)
  }
}

module.exports = new HistoryService()
