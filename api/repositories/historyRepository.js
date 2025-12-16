const pool = require('../database/connector')

class HistoryRepository {
  async findAll(limit = null, offset = 0) {
    if (limit === null) {
      const result = await pool.query('SELECT * FROM public.history ORDER BY id')
      return result.rows
    }
    const result = await pool.query(
      'SELECT * FROM public.history ORDER BY id LIMIT $1 OFFSET $2',
      [limit, offset]
    )
    return result.rows
  }

  async findById(id) {
    const result = await pool.query('SELECT * FROM public.history WHERE id = $1', [id])
    return result.rows[0]
  }

  async create(data) {
    const { id_company, source, status } = data
    const result = await pool.query(
      'INSERT INTO public.history (id_company, source, status) VALUES ($1, $2, $3) RETURNING *',
      [id_company, source || null, status]
    )
    return result.rows[0]
  }

  async update(id, data) {
    const { id_company, source, datetime, status } = data

    let query, params
    if (datetime) {
      query = 'UPDATE public.history SET id_company = $1, source = $2, datetime = $3, status = $4 WHERE id = $5 RETURNING *'
      params = [id_company, source || null, datetime, status, id]
    } else {
      query = 'UPDATE public.history SET id_company = $1, source = $2, status = $3 WHERE id = $4 RETURNING *'
      params = [id_company, source || null, status, id]
    }

    const result = await pool.query(query, params)
    return result.rows[0]
  }

  async delete(id) {
    const result = await pool.query('DELETE FROM public.history WHERE id = $1 RETURNING *', [id])
    return result.rows[0]
  }
}

module.exports = new HistoryRepository()
