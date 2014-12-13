
exports.session = require './session'
exports.transmitter = require './transmitter'

exports.Store = require './store'

exports.ws = null
exports.send = (name, data) ->
  action = {name, data}
  raw = JSON.stringify action, null, 2
  @ws.send raw
