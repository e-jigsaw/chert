require! {
  \./adapters.config.ls : config
}

module.exports = ->
  adapters = {}
  Object.keys config
    .forEach (key)->
      adapter = require "#{__dirname}/adapters/#{config[key].runner}"
      adapters[key] =
        run: adapter.run
  adapters
