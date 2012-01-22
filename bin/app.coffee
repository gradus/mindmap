util = require 'util'
flatiron = require 'flatiron'
app = flatiron.app
Plates = require 'plates'
html = '<span class="name">Name</span>'
colors = '<a href="/yellow"><div style="background-color:yellow;">yellow</div>
          <a href="/yellow"><div style="background-color:green;">green</div>
          <a href="/yellow"><div style="background-color:red;">red</div>
          <a href="/yellow"><div style="background-color:orange;">orange</div>
          <a href="/yellow"><div style="background-color:blue;">blue</div>
'
app.use(flatiron.plugins.http)

app.router.get('/', () ->
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  this.res.end('Playing with flatiron and nodejitsu<br />' + colors)
)

app.router.get(/\/version/, () ->
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  this.res.end('flatiron ' + flatiron.version)
)

app.router.get(':page', (page) ->
  this.res.writeHead(200, { 'Content-Type': 'text/html' })
  data = { "page": page }
  map = Plates.Map()
  map.class('name').to('page')
  name = Plates.bind(html, data, map)
  this.res.end(name)
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
app.start(3000)

