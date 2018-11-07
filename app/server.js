const express = require('express')
const path = require('path')
const bodyParser = require('body-parser')
const Client = require('pg').Client
const client = new Client()

const app = express()
const port = process.env.PORT || 5000
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(express.static(path.resolve(__dirname, 'build')))

app.get('/api/ping', async (req, res) => {

  await client.connect()
  
  const results = await client.query('SELECT * from account')
  console.log(results.rows)
  await client.end()
  res.json(results.rows)
})

app.listen(port, () => console.log(`Listening on port ${port}`));