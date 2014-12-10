
lodash = require 'lodash'

key = 'cumulo-client-session'
session = {}

window.onbeforeunload = ->
  raw = JSON.stringify session
  localStorage.setItem key, raw

# expose API

exports.init = (options) ->
  # required options
  key = options.key
  initialSession = options.initialSession

  try
    raw = localStorage.getItem key
    session = JSON.parse (raw or null)
  catch error
    console.warn 'error parsing session JSON', error

  unless session?
    session = initialSession

exports.set = (data) ->
  lodash.assign session, data

exports.get = ->
  session