marked = require 'marked'

module.exports = (note)->
  switch note.type
    when 'md' then marked note.body
