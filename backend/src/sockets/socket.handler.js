
const {Server} = require('socket.io');
const jwt = require('jsonwebtoken');

function initWebSocket(server){
    
    const io = new Server(server,{
        cors:{
            origin: "*", // Allows tunnel proxies like ngrok to pass connections without CORS block
            methods: ["GET", "POST"]
        },
        transports: ['websocket', 'polling']
    });

    io.use((socket, next) => {
        try{

            const token = socket.handshake.auth?.token || socket.handshake.headers['authorization'];

            if(!token){
                console.error('[WebSocket Auth] Connection Rejected: Missing Token Payload.');
                return next(new Error('Authentication failed: No token provided.'));
            }

            // clean the token if passed with standard Bearer prefix
            const cleanToken = token.startsWith('Bearer ') ? token.slice(7) : token;

            const decoded = jwt.verify(cleanToken, process.env.JWT_SECRET) || "your_fallback_secret";

            socket.user = decoded;

            console.log(`[WebSocket Auth] Token verified for User ID: ${decoded.id || 'Unknown ID'}`);
            next();

        } catch(error){
            console.error('[WebSocket Auth] Connection Rejected: Token verification failed. ', error.message);
            return next(new Error('Authentication Failed: Invalid or expired Token'));
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