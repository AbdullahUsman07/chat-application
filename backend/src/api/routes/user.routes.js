
const express = require('express');
const router = express.Router();
const userController = require('../../components/users/user.controller');
const authMiddleware = require('../middleware/auth.middleware');

router.post('/fcm-token', authMiddleware, userController.handleRegisterFcmToken);
router.delete('/fcm-token', authMiddleware, userController.handleRemoveFcmToken);

module.exports = router;