
const {Server} = require('socket.io');
const jwt = require('jsonwebtoken');
const presenceManager = require('./presence.manager');
const chatService = require('../components/chat/chat.service');

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

    io.on('connection', async (socket) => {
        const userId = socket.user?.id || socket.user?.userId;
        console.log(`[WebSocket] New client connected. Socket ID: ${socket.id}  (UserId : ${userId})`);

        if(userId){
            await presenceManager.addSocket(userId, socket.id);
        }

        socket.on('send_message', async (data, callback) => {
            try{
                const {roomId, payload, clientUuid } = data;
                console.log(`[WebSocket] Incoming message from User ${userId} for Room ${roomId}: "${payload}"`);

                // Write to postgreSQL and query Redis Recipient Sockets
                const {message, recipientSockets} = await chatService.processOutboundMessage({
                    roomId,
                    senderId: userId,
                    payload
                });

                // fan-out real-time broadcast to online recipient sockets
                recipientSockets.forEach(targetSocketId => {
                    io.to(targetSocketId).emit('receive_message', message);
                })

                // acknwoledge back to sender
                if (typeof callback == 'function'){
                    callback({
                        status: 'ok',
                        clientUuid,
                        message
                    });
                }
            }catch(error){
                console.error('[WebSocket Error] Message handling failed: ', error);
                if (typeof callback == 'function'){
                    callback({status: 'error', message: error.message});
                }
            }
        });

        // standard echo placeholder for connection verification testing
        socket.on('ping_test', (data) =>{
            console.log(`[WebSocket] Recieved ping_test: `, data);
            socket.emit('pong_test', {message: "Server Handshake Acknowledged!", timestamp: new Date()});
        });

        socket.on('disconnect', async () =>{
            console.log(`[WebSocket] Client Disconnected. Socket ID: ${socket.id} (User ID: ${userId})`);
            if(userId){
                await presenceManager.removeSocket(userId,socket.id);
            }
        });
    });

    return io;
}

module.exports = initWebSocket;