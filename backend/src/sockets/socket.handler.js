
const {Server} = require('socket.io');

function initWebSocket(server){
    
    const io = new Server(server,{
        cors:{
            origin: "*", // Allows tunnel proxies like ngrok to pass connections without CORS block
            methods: ["GET", "POST"]
        }
    });

    io.on('connection', (socket) => {
        console.log(`[WebSocket] New client connected. Socket ID: ${socket.id}`);

        // standard echo placeholder for connection verification testing
        socket.on('ping_test', (data) =>{
            console.log(`[WebSocket] Recieved ping_test: `, data);
            socket.emit('pong_test', {message: "Server Handshake Acknowledged!", timestamp: new Date()});
        });

        socket.on('disconnect', () =>{
            console.log(`[WebSocket] Client Disconnected. Socket ID: ${socket.id}`);
        });
    });

    return io;
}

module.exports = initWebSocket;