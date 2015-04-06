require! {
  \koa.io : koa
  \koa-router : Router
  \koa-static : serve
  \koa-jade : jade
  react: {renderToString, createElement}
  season
  mongoose
  \./src/components/App
  \./src/loadAdapters
}

app = koa!
router = Router!
adapters = loadAdapters!

config = season.readFileSync \.config.cson
mongoose.connect config.mongodb
Notebook = mongoose.model \Notebooks,
  name: String
  notes: [
    type: mongoose.Schema.ObjectId
    ref: \Notes
  ]
Note = mongoose.model \Notes,
  type: String
  body: String
  result: String
  isExpand: Boolean

app.use serve \build
app.use jade.middleware do
  viewPath: "#{__dirname}/views"

router.get \/, ->*
  nbs = yield Notebook.find!.exec!
  yield @render \index,
    markup: renderToString createElement App,
      routes: \/
      initialData: nbs
    data: JSON.stringify nbs

router.get \/new, ->*
  nb = yield Notebook.create do
    name: "Notebook #{new Date()}"
  @redirect "/n/#{nb._id}"

router.get \/n/:id, ->*
  nb = yield Notebook
    .findById @params.id
    .populate \notes
    .exec!
  yield @render \index,
    markup: renderToString createElement App,
      routes: @request.url
      initialData: nb
    data: JSON.stringify nb

app.use router.routes!

app.io.route \notebook:new, ->*
  nb = yield Notebook
    .findById @data[0].id
    .exec!
  n = new Note do
    type: \md
    body: ''
    result: ''
    isExpand: true
  nb.notes.push n._id
  n.save (err)~> nb.save (err)~> @emit \notebook:created, n._id

app.io.route \notebook:changeName, ->*
  notebook = @data[0]
  nb = yield Notebook
    .findById notebook.id
    .exec!
  nb.name = notebook.name
  nb.save (err)~> @emit \notebook:changeNameSuccess

app.io.route \note:update, ->*
  note = @data[0]
  n = yield Note
    .findById note.id
    .exec!
  n.type = note.type
  n.body = note.body
  n.result = adapters[note.type].run note
  n.save (err)~> @emit \note:updated, n

app.io.route \note:toggleExpand, ->*
  note = @data[0]
  n = yield Note
    .findById note.id
    .exec!
  n.isExpand = !n.isExpand
  n.save (err)~> @emit \note:toggleExpandSuccess

port = process.env.PORT or 3000
app.listen port
console.log "listening on #{port}"
