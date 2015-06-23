var http = require('http');

var server = http.createServer(function(req, res) {
  res.writeHead(200);
  res.end('Salut tout le monde !');
});
server.listen(8080,'0.0.0.0',function () {
  console.log('Listening on http://0.0.0.0:8080');
});