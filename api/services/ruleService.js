const ruleRepository = require('../repositories/ruleRepository')

class RuleService {
  async getAll(limit, offset) {
    return await ruleRepository.findAll(limit, offset)
  }

  async getById(id) {
    return await ruleRepository.findById(id)
  }

  async create(data) {
    return await ruleRepository.create(data)
  }

  async update(id, data) {
    return await ruleRepository.update(id, data)
  }

  async delete(id) {
    return await ruleRepository.delete(id)
  }
}

module.exports = new RuleService()
