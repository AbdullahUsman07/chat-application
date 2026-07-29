
const { Server } = require('socket.io');
const jwt = require('jsonwebtoken');
const presenceManager = require('./presence.manager');
const chatService = require('../components/chat/chat.service');

function initWebSocket(server) {

    const io = new Server(server, {
        cors: {
            origin: "*", // Allows tunnel proxies like ngrok to pass connections without CORS block
            methods: ["GET", "POST"]
        },
        transports: ['websocket', 'polling']
    });

    io.use((socket, next) => {
        try {

            const token = socket.handshake.auth?.token || socket.handshake.headers['authorization'];

            if (!token) {
                console.error('[WebSocket Auth] Connection Rejected: Missing Token Payload.');
                return next(new Error('Authentication failed: No token provided.'));
            }

            // clean the token if passed with standard Bearer prefix
            const cleanToken = token.startsWith('Bearer ') ? token.slice(7) : token;

            const decoded = jwt.verify(cleanToken, process.env.JWT_SECRET) || "your_fallback_secret";

            socket.user = decoded;

            console.log(`[WebSocket Auth] Token verified for User ID: ${decoded.id || 'Unknown ID'}`);
            next();

        } catch (error) {
            console.error('[WebSocket Auth] Connection Rejected: Token verification failed. ', error.message);
            return next(new Error('Authentication Failed: Invalid or expired Token'));
        }
    });

    io.on('connection', async (socket) => {
        const userId = socket.user?.id || socket.user?.userId;
        console.log(`[WebSocket] New client connected. Socket ID: ${socket.id}  (UserId : ${userId})`);

        if (userId) {
            await presenceManager.addSocket(userId, socket.id);
        }

        socket.on('send_message', async (data, callback) => {
            try {
                const { roomId, payload, clientUuid } = data;
                console.log(`[WebSocket] Incoming message from User ${userId} for Room ${roomId}: "${payload}"`);

                // Write to postgreSQL and query Redis Recipient Sockets
                const { message, recipientSockets } = await chatService.processOutboundMessage({
                    roomId,
                    senderId: userId,
                    payload
                });

                // fan-out real-time broadcast to online recipient sockets
                recipientSockets.forEach(targetSocketId => {
                    io.to(targetSocketId).emit('receive_message', message);
                })

                // acknwoledge back to sender
                if (typeof callback == 'function') {
                    callback({
                        status: 'ok',
                        clientUuid,
                        message
                    });
                }
            } catch (error) {
                console.error('[WebSocket Error] Message handling failed: ', error);
                if (typeof callback == 'function') {
                    callback({ status: 'error', message: error.message });
                }
            }
        });

        // recipient notifies server that message was received on device
        socket.on('message_delivered', async (data) => {
            try {
                const { messageId, messageIds, senderId } = data;

                // normalize input into an array 
                const idsToUpdate = messageIds || (messageId ? [messageId] : []);
                if (idsToUpdate.length == 0) return;

                const updatedMessages = await chatService.markMessagesDeliveredBatch(idsToUpdate);

                if (idsToUpdate.length > 0) {

                    // retrieve active sockets for the original SENDER from Redis
                    const senderSockets = await presenceManager.getUserSockets(senderId);

                    // broadcast status update back to sender's active devices
                    senderSockets.forEach(targetSocketId => {
                        io.to(targetSocketId).emit('message_status_updated', {
                            messageIds: updatedMessages.map(m => m.id),
                            roomId: updatedMessages[0].room_id,
                            status: 'delivered'
                        });
                    });
                }
            } catch (error) {
                console.error('[WebSocket Error] Delivery receipt failed: ', error.message);
            }
        });

        // recipient open chat room and views messages
        socket.on('message_read', async (data) => {
            try {
                const { roomId, senderId } = data;
                const userId = socket.user.id;

                // bulk update unread messages in DB to 'read'
                const updatedMessages = await chatService.markRoomAsRead(roomId, userId);

                if (updatedMessages.length > 0) {
                    // find active sockets for the original SENDER from redis
                    const senderSockets = await presenceManager.getUserSockets(senderId);
                    console.log(`[Sender Websocket]: ${senderSockets}`);

                    // notify sender that messages were read
                    senderSockets.forEach(targetSocketId => {
                        io.to(targetSocketId).emit('message_status_updated', {
                            roomId,
                            status: 'read',
                            updatedCount: updatedMessages.length
                        });
                    })
                }
            } catch (error) {
                console.error('[WebSocket Error] Read receipt failed: ', error.message);
            }
        });

        socket.on('sync_missed_messages', async (data) => {
            try {
                const { roomId, lastKnownPostgresId } = data;
                const userId = socket.user.id;

                if (!roomId) {
                    return socket.emit('error', { message: 'roomId is required for catch-up sync' });
                }

                const sinceId = lastKnownPostgresId || 0;

                const query = `
                SELECT 
                    id AS "postgresId",
                    room_id AS "roomId",
                    sender_id AS "senderId",
                content,
                status,
                created_at AS "createdAt"
                FROM messages
                WHERE room_id = $1 AND id > $2
                ORDER BY id ASC
                LIMIT 200; -- Cap catch-up batch size to prevent socket frame bloat
                `;

                const { rows: missedMessages } = await db.query(query, [roomId, sinceId]);

                socket.emit('missed_messages_batch', {
                    roomId,
                    lastKnownPostgresId: sinceId,
                    messages: missedMessages,
                    count: missedMessages.length
                });
                console.log(`[SYNC] Emitted ${missedMessages.length} missed messages for Room ${roomId} to User ${userId}`);
            } catch (error) {
                console.error('[SYNC ERROR] Failed to fetch missed messages:', error.message);
                socket.emit('sync_error', { message: 'Failed to synchronize missed messages.' });
            }
        })

        // standard echo placeholder for connection verification testing
        socket.on('ping_test', (data) => {
            console.log(`[WebSocket] Recieved ping_test: `, data);
            socket.emit('pong_test', { message: "Server Handshake Acknowledged!", timestamp: new Date() });
        });

        socket.on('disconnect', async () => {
            console.log(`[WebSocket] Client Disconnected. Socket ID: ${socket.id} (User ID: ${userId})`);
            if (userId) {
                await presenceManager.removeSocket(userId, socket.id);
            }
        });
    });

    return io;
}

module.exports = initWebSocket;