require! {
  react : {render, createFactory}
  \./components/App
}

render createFactory(App) do
  routes: location.pathname
  initialData: document
    .getElementById \initialData
    .getAttribute \data-json
    |> JSON.parse
, document.getElementById \app
