require! {
  react: {Component, DOM}
}

module.exports = class NoteResult extends Component
  displayName: \noteResult
  styles:
    container:
      minHeight: \300px
    plainResult:
      whiteSpace: \pre

  generate: ->
    # FIXME: export below result generate functions
    switch @props.type
      when \md
        DOM.div do
          key: "#{@props.id}-note-result-body"
          className: \markdown-body
          dangerouslySetInnerHTML:
            __html: @props.data
      else
        DOM.div do
          key: "#{@props.id}-note-result-body"
          style: @styles.plainResult
          @props.data

  render: ->
    DOM.div do
      key: "#{@props.id}-note-result-container"
      style: @styles.container
      [@generate!]
