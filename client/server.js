express.static(root, [options]);
app.use(express.static('public'));
app.use(express.static('public'));
app.use(express.static('files'));
app.use('/static', express.static('public'));
app.use('/static', express.static(path.join(__dirname, 'public')));

var http = require('http');
var fs = require('fs');

function send404Response(response){
	response.writeHead(404, {"Content-Type": "text/plain"});
	response.write("Error 404: Page not found!");
	response.end();

}

function onRequest(request, response){
	if(request.method == 'GET' && request.url == '/'){
		response.writeHead(200, {"Content-Type": "application/javascript"});
		fs.createReadStream("index.js").pipe(response);
	}else{
		send404Response(response);
	}
}

http.createServer(onRequest).listen(8888);
console.log("Server is now running...");