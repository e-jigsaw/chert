React = require \react
App = require \./components/index

React.render React.createElement App,
  routes: location.pathname
  initialData: document
    .getElementById \initialData
    .getAttribute \data-json
    |> JSON.parse
  , document.getElementById \app
