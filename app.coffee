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
html = '<span class="name">Name</span>'

app.router.get(/\/version/, () ->
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  this.res.end('flatiron ' + flatiron.version)
)

app.router.get(':color', (color) ->
  response = this.res
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  data = { "page": "<body style='background-color:" + color + "'>" + color }
  map = Plates.Map()
  map.class('name').to('page')
  name = Plates.bind(html, data, map)
  layout = (filename, encoding) -> fs.readFile(filename, encoding, (error, data) ->
    @content = data
    console.log @content
  )


  this.res.end(@content + name)
)
app.start(3000)

console.log('Listening on :3000')

