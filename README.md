
Cumulo Client
----

Client side toolkits for Cumulo architechture.

### Usage

This is a CommonJS package you can use with Browserify:

```
npm i --save-dev cumulo-client
```

`cumulo-client` exposes several objects and contructors:

```coffee
# a session manager
exports.session = require './session'
# a router like event hub
exports.transmitter = require './transmitter'

# data store to be synced with server
exports.Store = require './store'

# websocket interface
exports.ws = null
exports.send = (name, data) ->
  action = {name, data}
  raw = JSON.stringify action, null, 2
  @ws.send raw
```

#### Session

```coffee
cumulo = require 'cumulo-client'
session = cumulo.session
session.init
  key: 'chat-distract' # localStorageKey
  initialSession: {} # a default object
```

* `session.get`

returns an object.

* `session.set(obj)`

`obj` is an object that will be `lodash.assign` to session object.
Session Object will be written to localStorage on `onbeforeunload`.

#### Transmitter

```coffee
cumulo = require 'cumulo-client'
transmitter = cumulo.transmitter

# an interface for debugging, create logs for events
transmitter.display = (action) ->
  console.info action

# transmitter pipes actions from websocket
ws.onmessage = (messageObject) ->
  raw = messageObject.data
  action = JSON.parse raw
  transmitter.dispatch action

# and listens events like an router, notice that
# .dispatch({name: '', data: {}})
# .register(name, (data)->)
transmitter.register 'client/patch', (data) =>
  store.patch data
```

#### Store

Cumulo store in client is simply listening to events and updating data:

```coffee
cumulo = require 'cumulo-client'

transmitter = cumulo.transmitter

# initial data is required, mind that it's used in patching
# data is mostly {} or [], see what you need in patching
store = new cumulo.Store data: []
module.exports = store

transmitter.register 'preview/sync', (data) =>
  store.sync data

transmitter.register 'preview/patch', (data) =>
  store.patch data
```

#### Send

Well, `send` is just an alias, and you need to attach `ws` to cumulo:

```coffee
# websocket interface
exports.ws = null
exports.send = (name, data) ->
  # on server, there's a router receiving this action
  action = {name, data}
  raw = JSON.stringify action, null, 2
  @ws.send raw
```

See [chat-distract][chat-distract] for Details.

[chat-distract]: https://github.com/Cumulo/chat-distract/tree/master/source

### License

MIT
