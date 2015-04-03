{Component, DOM} = require \react

module.exports = class NoteName extends Component
  displayName: \noteName
  styles:
    container:
      paddingBottom: \1em
      marginBottom: \1em
      borderBottom: '1px solid #c4c4c4'
      textAlign: \right
    button:
      marginLeft: \1em

  getInitialState: ->
    buttonEnable: false

  check: (event)->
    @setState do
      buttonEnable: @props.data isnt event.target.value

  buttonClass: ->
    if @state.buttonEnable then 'pure-button pure-button-primary' else 'pure-button pure-button-disabled'

  changeName: ->
    @props.changeName @refs.input.getDOMNode!.value

  componentWillReceiveProps: ->
    @setState do
      buttonEnable: false

  render: ->
    DOM.div do
      key: "#{@props.id}-note-name-container"
      style: @styles.container
      className: \pure-form
      , [
        DOM.input
          key: "#{@props.id}-note-name-input"
          defaultValue: @props.data
          ref: \input
          onKeyUp: @check
        DOM.button
          key: "#{@props.id}-note-name-button"
          className: @buttonClass!
          style: @styles.button
          onClick: @changeName
          , \Update
      ]
