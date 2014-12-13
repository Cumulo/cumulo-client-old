
Dispatcher = require './util/dispatcher'
lodash = require 'lodash'
jsondiffpatch = require 'jsondiffpatch'

diffpatch = jsondiffpatch.create
  objectHash: (obj) -> obj.id

module.exports = class CumuloStore extends Dispatcher
  constructor: (options) ->
    super
    @data = options.data

  sync: (data) ->
    @data = data
    @dispatch()

  patch: (diff) ->
    @data = diffpatch.patch @data, diff
    @dispatch()

  get: ->
    lodash.cloneDeep @data
