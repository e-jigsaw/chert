require! {
  react: {Component, DOM}
}

module.exports = class NotebookLink extends Component
  displayName: \notebooksLink

  generateLinks: -> @props.notebooks.map (notebook)->
    DOM.li do
      key: "#{notebook._id}-link"
      [
        DOM.a do
          key: "#{notebook._id}-a"
          href: "/n/#{notebook._id}"
          notebook.name
      ]

  render: ->
    DOM.ul do
      key: \notebooksLink-ul
      @generateLinks!
