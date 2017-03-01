var WebSocketServer = require('uws').Server;
var express = require('express')
var app = express()

var wss = new WebSocketServer({ port: 3000 });

var ws;
var previousValue;

app.get('/', function (req, res) {
  const newValue = req.query.q;

  if(previousValue != newValue) {
    previousValue = newValue;

    if(ws) {
      ws.send(newValue);
    }
  }

  res.send();
});

app.listen(4242, function () {
  console.log('Example app listening on port 4242!');
});

wss.on('connection', function(x) {
  ws = x;
});
