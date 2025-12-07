const pool = require('../database/connector')

class CompanyRepository {
  async findAll(limit = null, offset = 0) {
    if (limit === null) {
      const result = await pool.query('SELECT * FROM public.company ORDER BY id')
      return result.rows
    }
    const result = await pool.query(
      'SELECT * FROM public.company ORDER BY id LIMIT $1 OFFSET $2',
      [limit, offset]
    )
    return result.rows
  }

  async findById(id) {
    const result = await pool.query('SELECT * FROM public.company WHERE id = $1', [id])
    return result.rows[0]
  }

  async create(data) {
    const { name, email, status } = data
    const result = await pool.query(
      'INSERT INTO public.company (name, email, status) VALUES ($1, $2, $3) RETURNING *',
      [name, email, status]
    )
    return result.rows[0]
  }

  async update(id, data) {
    const { name, email, status } = data
    const result = await pool.query(
      'UPDATE public.company SET name = $1, email = $2, status = $3 WHERE id = $4 RETURNING *',
      [name, email, status, id]
    )
    return result.rows[0]
  }

  async delete(id) {
    const result = await pool.query('DELETE FROM public.company WHERE id = $1 RETURNING *', [id])
    return result.rows[0]
  }
}

module.exports = new CompanyRepository()
