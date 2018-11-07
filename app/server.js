const express = require('express')
const path = require('path')
const bodyParser = require('body-parser')
const { Client } = require('pg')

const app = express()
const CONN_STRING = process.env.DATABASE_URL || 'postgres://localhost:5432/'
const port = process.env.PORT || 5000

const client = new Client({ connectionString: CONN_STRING })

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(express.static(path.resolve(__dirname, 'build')))

app.get('/api/all', async (req, res) => {
  await client.connect()
  const result = await client.query('SELECT * from account')
  // console.log(result.rows)
  await client.end()
  res.json(result.rows)
})

app.get('/api/ping', (req, res) => { res.send('pong') })

app.listen(port, () => console.log(`Listening on port ${port}`));