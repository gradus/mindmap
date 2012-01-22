util = require 'util'
flatiron = require 'flatiron'
app = flatiron.app
Plates = require 'plates'
html = '<div id="body"></div>'
data = { "body": "Playing with Flatiron and plates examples in coffee" }

output = Plates.bind(html, data)

app.use(flatiron.plugins.http)

app.router.get('/', () ->
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  this.res.end(output)
)

app.router.get(/\/version/, () ->
  this.res.writeHead(200, { 'Content-Type': 'text/plain' })
  this.res.end('flatiron ' + flatiron.version)
)

app.router.post('/', () ->
  this.res.writeHead(200, { 'Content-Type': 'text/plain' })
  this.res.write('Hey, you posted some cool data!\n')
  this.res.end(util.inspect(this.req.body, true, 2, true) + '\n')
)

app.router.get('/sandwich/:type', (type) ->
  if ~['bacon', 'burger'].indexOf(type)
    this.res.writeHead(200, { 'Content-Type': 'text/html' })
    this.res.end('Serving ' + type + ' sandwich!\n')
  else
    this.res.writeHead(404, { 'Content-Type': 'text/html' })
    this.res.end('No such sandwich, sorry!\n')
)
app.start(8080)

