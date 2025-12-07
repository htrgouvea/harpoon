const pool = require('../database/connector')

class AlertRepository {
  async findAll(limit = null, offset = 0) {
    if (limit === null) {
      const result = await pool.query('SELECT * FROM public.alert ORDER BY id')
      return result.rows
    }
    const result = await pool.query(
      'SELECT * FROM public.alert ORDER BY id LIMIT $1 OFFSET $2',
      [limit, offset]
    )
    return result.rows
  }

  async findById(id) {
    const result = await pool.query('SELECT * FROM public.alert WHERE id = $1', [id])
    return result.rows[0]
  }

  async create(data) {
    const { id_company, status, notification, content, hash } = data
    const result = await pool.query(
      'INSERT INTO public.alert (id_company, status, notification, content, hash) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [id_company, status, notification, content, hash]
    )
    return result.rows[0]
  }

  async update(id, data) {
    const { id_company, datetime, status, notification, content, hash } = data

    let query, params
    if (datetime) {
      query = 'UPDATE public.alert SET id_company = $1, datetime = $2, status = $3, notification = $4, content = $5, hash = $6 WHERE id = $7 RETURNING *'
      params = [id_company, datetime, status, notification, content, hash, id]
    } else {
      query = 'UPDATE public.alert SET id_company = $1, status = $2, notification = $3, content = $4, hash = $5 WHERE id = $6 RETURNING *'
      params = [id_company, status, notification, content, hash, id]
    }

    const result = await pool.query(query, params)
    return result.rows[0]
  }

  async delete(id) {
    const result = await pool.query('DELETE FROM public.alert WHERE id = $1 RETURNING *', [id])
    return result.rows[0]
  }
}

module.exports = new AlertRepository()
