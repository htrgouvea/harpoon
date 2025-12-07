const companyRepository = require('../repositories/companyRepository')

class CompanyService {
  async getAll(limit, offset) {
    return await companyRepository.findAll(limit, offset)
  }

  async getById(id) {
    return await companyRepository.findById(id)
  }

  async create(data) {
    return await companyRepository.create(data)
  }

  async update(id, data) {
    return await companyRepository.update(id, data)
  }

  async delete(id) {
    return await companyRepository.delete(id)
  }
}

module.exports = new CompanyService()
