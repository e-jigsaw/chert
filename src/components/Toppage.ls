{Component, DOM, createElement} = require \react
NBLink = require \./notebooksLink

module.exports = class Toppage extends Component
  displayName: \toppage
  styles:
    container:
      padding: '.5em 1em .5em 1em'

  render: ->
    DOM.div do
      key: \toppage
      style: @styles.container
      , [
        DOM.h1 do
          key: \toppage-header
          , 'Welcome chert'
        DOM.p
          key: \toppage-description
          , 'Chert is a Web-based notebook tool with Apache Spark.'
        DOM.p
          key: \toppage-notelink-container
          , [
            DOM.a
              key: \toppage-notelink
              href: \/new
              , 'Create new notebook'
          ]
        DOM.h2
          key: \notebooksLink-header
          , \Notebooks
        createElement NBLink,
          key: 'notebooksLink'
          notebooks: @props.notebooks
      ]
