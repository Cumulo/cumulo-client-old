
routes = {}

exports.register = (name, cb) ->
  if routes[name]? then console.warn "rewriting #{name}"
  routes[name] = cb

exports.dispatch = (action) ->
  @display? action
  handler = routes[action.name]
  if handler
  then handler action.data
  else console.warn 'no handler for', action

exports.unregister = (name) ->
  delete routes[name]
