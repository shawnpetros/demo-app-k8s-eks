import React, { Component } from 'react'
import logo from './logo.svg'
import './App.css'

class App extends Component {
  state = {
    dbResponse: []
  }
  async dbQuery () {
    const response = await fetch('/api/all')
    const body = await response.json()
    if (response.status !== 200) throw Error(body.message)
    this.setState({ dbResponse: body })
  }
  makeList (item) {
    return <p style={{ fontSize: '2vmin' }}>
      User ID: { item.user_id },
      Username: { item.username },
      Password: { item.password },
      Email: { item.email },
      Created On: { item.created_on }
    </p>
  }
  render () {
    return (
      <div className='App'>
        <header className='App-header'>
          <img src={logo} className='App-logo' alt='logo' />
          <p>
            Edit <code>src/App.js</code> and save to reload.
          </p>
          <button
            className='App-link'
            onClick={this.dbQuery.bind(this)}
          >
            Query DB
          </button>
          <div>{ this.state.dbResponse.map(this.makeList)}</div>
        </header>
      </div>
    )
  }
}

export default App
