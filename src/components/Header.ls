{Component, DOM} = require 'react'

module.exports = class Header extends Component
  displayName: \header
  styles:
    container:
      backgroundColor: \#a20000
      padding: '.5em 1em .5em 1em'
    logo:
      fontSize: \2em
      textDecoration: \none
      color: \#f3f3f3

  render: ->
    DOM.div do
      key: \header
      style: @styles.container
      , [
        DOM.a
          key: \header-logo-a
          style: @styles.logo
          href: \/
          , \chert
      ]
