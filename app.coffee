union = require('union')
flatiron = require('flatiron')
ecstatic = require('ecstatic')
fs = require('fs')

app = new flatiron.App()
app.use(flatiron.plugins.http)

app.http.before = [
  ecstatic(__dirname + '/public')
]

Plates = require 'plates'
map = Plates.Map()
html = ''
layout = (filename, encoding) -> fs.readFile(filename, encoding, (error, data) ->
  html = html + data
)
layout('./public/layout.html', 'utf8')
colorSpan = '<span class="name">Name</span>'

app.router.get(/\/version/, () ->
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  this.res.end('flatiron ' + flatiron.version)
)

app.router.get(':color', (color) ->
  response = this.res
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  data = { "page": "<body style='background-color:" + color + "'>"}
  map.class('name').to('page')
  name = Plates.bind(colorSpan, data, map)
  this.res.end(html + name)
)
app.start(3000)

console.log('Listening on :3000')

