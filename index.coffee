koa = require 'koa'
Router = require 'koa-router'
serve = require 'koa-static'
jade = require 'koa-jade'
app = koa()
router = Router()

app.use serve 'build'
app.use jade.middleware
  viewPath: "#{__dirname}/views"

router.get '/', ->
  yield @render 'index'

router.get '/:id', (next)->
  @body = "Hello #{@params.id}"
  yield next

app.use router.routes()

port = process.env.PORT || 3000
app.listen port
console.log "listening on #{port}"
