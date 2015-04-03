require! {
  react: {Component, DOM}
}

module.exports = class NoteController extends Component
  displayName: \noteController
  styles:
    select:
      marginRight: \.4em

  render: ->
    DOM.div do
      key: "#{@props.id}-note-controller-container"
      className: \pure-form
      [
        DOM.select do
          key: "#{@props.id}-note-controller-select"
          style: @styles.select
          [
            DOM.option do
              key: "#{@props.id}-note-controller-select-md"
              \Markdown
          ]
        DOM.button do
          key: "#{@props.id}-note-controller-run"
          className: 'pure-button pure-button-primary'
          onClick: @props.run
          \▶Run
      ]
