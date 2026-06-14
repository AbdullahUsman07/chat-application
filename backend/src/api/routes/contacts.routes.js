
const express = require('express');
const contactsController = require('../../components/contacts/contacts.controller');
const authenticateToken = require('../middleware/auth.middleware');

const router = express.Router();

router.use(authenticateToken);

router.post('/sync', contactsController.sync);
router.post('/search', contactsController.search);

module.exports = router;