
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const http = require('http');
const initWebSocket = require('./src/sockets/socket.handler');
const authRoutes = require('./src/api/routes/auth.routes');
const contactRoutes = require('./src/api/routes/contacts.routes');
const chatRoutes = require('./src/api/routes/chats.routes');


const app = express();
const server = http.createServer(app);

app.use(cors()); // allows the flutter app to make request without cors blocks
app.use(express.json()); // parse incoming json payloads

app.use('/api/auth', authRoutes);
app.use('/api/contacts', contactRoutes);


app.get('/api/health', (req,res) =>{
    res.status(200).json({
        success: true,
        message: 'Chat App Backend is live and reached on the Network!'
    });
});

const io = initWebSocket(server);

// start the server bound ot 0.0.0.0 for extennal network access
const PORT = process.env.PORT || 3000;
app.listen(PORT, '0.0.0.0', ()=>{
    console.log('\n--------------------\n');
    console.log(`Server Running dynamically on http://0.0.0.0:${PORT}`);
})