
Dispatcher = require './util/dispatcher'
lodash = require 'lodash'

module.exports = class CumuloStore extends Dispatcher
  constructor: (options) ->
    super
    @data = {}
    @listen = options.listen

  listen: ->
    # rewrite in project

  sync: (data) ->
    @data = data
    @dispatch()

  patch: (diff) ->
    @data = diffpatch.patch @data, diff
    @dispatch()

  get: ->
    lodash.cloneDeep @data
