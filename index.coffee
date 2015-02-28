koa = require 'koa'
Router = require 'koa-router'
serve = require 'koa-static'
jade = require 'koa-jade'
React = require 'react'
season = require 'season'
mongoose = require 'mongoose'
App = require './src/components/index'
app = koa()
router = Router()

config = season.readFileSync '.config.cson'
mongoose.connect config.mongodb
Notebook = mongoose.model 'Notebook',
  notes: [
    command: String
    result: String
  ]

app.use serve 'build'
app.use jade.middleware
  viewPath: "#{__dirname}/views"

router.get '/', ->
  yield @render 'index',
    markup: React.renderToString React.createElement(App, {routes: '/'})

router.get '/new', (next)->
  nb = yield Notebook.create {}
  @redirect "/n/#{nb._id}"
  yield next

router.get '/n/:id', (next)->
  @body = "Hello #{@params.id}"
  yield next

app.use router.routes()

port = process.env.PORT || 3000
app.listen port
console.log "listening on #{port}"
