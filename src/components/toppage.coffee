React = require 'react'
NBLink = require './notebooksLink'

module.exports = React.createClass
  displayName: 'toppage'
  styles:
    container:
      padding: '.5em 1em .5em 1em'

  render: ->
    React.DOM.div
      key: 'toppage'
      style: @styles.container
    , [
      React.DOM.h1
        key: 'toppage-header'
      , 'Welcome chert'
    ,
      React.DOM.p
        key: 'toppage-description'
      , 'Chert is a Web-based notebook tool with Apache Spark.'
    ,
      React.DOM.p
        key: 'toppage-notelink-container'
      , [
        React.DOM.a
          key: 'toppage-notelink'
          href: '/new'
        , 'Create new notebook'
      ]
      React.DOM.h2
        key: 'notebooksLink-header'
      , 'Notebooks'
      React.createElement NBLink,
        key: 'notebooksLink'
        notebooks: @props.notebooks
    ]
