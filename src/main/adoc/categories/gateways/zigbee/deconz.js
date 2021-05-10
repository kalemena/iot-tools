const WebSocket = require('ws');

const host = '192.168.1.46';
const port = 40460;

const ws = new WebSocket('ws://' + host + ':' + port);

ws.onmessage = function(msg) {
    console.log(JSON.parse(msg.data));
}
