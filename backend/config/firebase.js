const admin = require('firebase-admin');
const { initializeApp, cert, getApps } = require('firebase-admin/app');
const path = require('path');

try {
    const serviceAccount = require(path.join(__dirname, 'serviceAccountKey.json'));

    if (getApps().length === 0) {
        initializeApp({
            credential: cert(serviceAccount)
        });
        console.log('[FCM] Firebase Admin Initialized Successfully!');
    } else {
        console.log('[FCM] Firebase Admin is already initialized.');
    }
} catch (error) {
    console.error('[FCM Error] Failed to initialize Firebase Admin SDK:', error.message);
}

module.exports = admin;