require! {
  react: {Component, DOM}
  \../adapters.config : config
}

module.exports = class NoteController extends Component
  displayName: \noteController
  styles:
    select:
      marginRight: \.4em

  adapters: ->
    Object.keys config
      .map (key)~>
        DOM.option do
          key: "#{@props.id}-note-controller-select-#{key}"
          value: key
          config[key].name

  render: ->
    DOM.div do
      key: "#{@props.id}-note-controller-container"
      className: \pure-form
      [
        DOM.select do
          key: "#{@props.id}-note-controller-select"
          style: @styles.select
          onChange: @props.typeChange
          defaultValue: @props.type
          @adapters!
        DOM.button do
          key: "#{@props.id}-note-controller-run"
          className: 'pure-button pure-button-primary'
          onClick: @props.run
          \▶Run
      ]
