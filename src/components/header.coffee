React = require 'react'

module.exports = React.createClass
  displayName: 'header'
  styles:
    container:
      backgroundColor: '#a20000'
      padding: '.5em 1em .5em 1em'
    logo:
      fontSize: '2em'
      textDecoration: 'none'
      color: '#f3f3f3'
  render: ->
    React.DOM.div
      key: 'header'
      style: @styles.container
    , [
      React.DOM.a
        key: 'header-logo-a'
        style: @styles.logo
        href: '/'
      , 'chert'
    ]
