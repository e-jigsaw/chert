React = require 'react'

module.exports = React.createClass
  displayName: 'notebooksLink'

  generateLinks: -> @props.notebooks.map (notebook)->
    React.DOM.li
      key: "#{notebook._id}-link"
    , [
      React.DOM.a
        key: "#{notebook._id}-a"
        href: "/n/#{notebook._id}"
      , notebook.name
    ]

  render: ->
    React.DOM.ul
      key: 'notebooksLink-ul'
    , @generateLinks()
