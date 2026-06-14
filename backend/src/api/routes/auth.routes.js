
const express = require('express');
const authController = require('../../components/auth/auth.controller');

const router = express.Router();

router.post('/signup', authController.signup);
router.post('/login', authController.login);

module.exports = router;