union = require('union')
flatiron = require('flatiron')
ecstatic = require('ecstatic')

app = new flatiron.App()
app.use(flatiron.plugins.http)

app.http.before = [
  ecstatic(__dirname + '/public')
]

Plates = require 'plates'
html = '<span class="name">Name</span>'


app.router.get('/', () ->
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  this.res.end(header + 'Playing with flatiron and nodejitsu<br />' + colors + footer)
)

app.router.get(/\/version/, () ->
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  this.res.end('flatiron ' + flatiron.version)
)

app.router.get(':page', (page) ->
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  data = { "page": "<body style='background-color:" + page + "'>" + page }
  map = Plates.Map()
  map.class('name').to('page')
  name = Plates.bind(html, data, map)
  this.res.end(name)
)
app.start(3000)

console.log('Listening on :3000')

