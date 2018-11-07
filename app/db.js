const pg = require('pg')

const conString = process.env.DATABASE_URL

const query = (qs) => {
  return new Promise((resolve, reject) => (
    pg.connect(conString, (err, client, done) => {
      if (err) return reject(new Error(err))
      client.query(qs, (err, result) => {
        if (err) {
          done()
          return reject(new Error(err))
        }
        done()
        resolve(result.rows)
      })
    })
  ))
}

const all = (table) => {
  return query(`SELECT * FROM ${table}`)
}

module.exports = all