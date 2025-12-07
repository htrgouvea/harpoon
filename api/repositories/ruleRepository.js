const pool = require('../database/connector')

class RuleRepository {
  async findAll(limit = null, offset = 0) {
    if (limit === null) {
      const result = await pool.query('SELECT * FROM public.rule ORDER BY id')
      return result.rows
    }
    const result = await pool.query(
      'SELECT * FROM public.rule ORDER BY id LIMIT $1 OFFSET $2',
      [limit, offset]
    )
    return result.rows
  }

  async findById(id) {
    const result = await pool.query('SELECT * FROM public.rule WHERE id = $1', [id])
    return result.rows[0]
  }

  async create(data) {
    const { id_company, string, filter, score, description, status } = data
    const result = await pool.query(
      'INSERT INTO public.rule (id_company, string, filter, score, description, status) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [id_company, string, filter, score, description, status]
    )
    return result.rows[0]
  }

  async update(id, data) {
    const { id_company, string, filter, score, description, status } = data
    const result = await pool.query(
      'UPDATE public.rule SET id_company = $1, string = $2, filter = $3, score = $4, description = $5, status = $6 WHERE id = $7 RETURNING *',
      [id_company, string, filter, score, description, status, id]
    )
    return result.rows[0]
  }

  async delete(id) {
    const result = await pool.query('DELETE FROM public.rule WHERE id = $1 RETURNING *', [id])
    return result.rows[0]
  }
}

module.exports = new RuleRepository()
