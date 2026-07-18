require('dotenv').config();
const express = require('express');
const cors = require('cors');
const http = require('http');
const initWebSocket = require('./src/sockets/socket.handler');
const authRoutes = require('./src/api/routes/auth.routes');
const contactRoutes = require('./src/api/routes/contacts.routes');

const app = express();
const server = http.createServer(app); // Unified Server Engine

app.use(cors()); 
app.use(express.json()); 

app.use('/api/auth', authRoutes);
app.use('/api/contacts', contactRoutes);

app.get('/api/health', (req, res) => {
    res.status(200).json({
        success: true,
        message: 'Chat App Backend is live and reached on the Network!'
    });
});

const io = initWebSocket(server);
console.log('[Initialization] WebSocket Gateway attached to HTTP server engine.');


const PORT = process.env.PORT || 3000;
server.listen(PORT, '0.0.0.0', () => {
    console.log('\n--------------------\n');
    console.log(` Server Running dynamically on http://0.0.0.0:${PORT}`);
    console.log('--------------------\n');
});