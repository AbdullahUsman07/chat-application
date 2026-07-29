
const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/auth.middleware');   
const { getUserRooms, getRoomMessages } = require('../../components/room/room.controller');


router.get('/', authMiddleware, getUserRooms);
router.get('/:roomId/messages', authMiddleware, getRoomMessages);

module.exports = router;