
const admin = require('firebase-admin');
const path = require('path');

try{
    const serviceAccount = require(path.join(__dirname, 'serviceAccountKey.json'));

    if(!admin.apps.length){
        admin.initializeApp({
            credential: admin.credential.cert(serviceAccount)
        });
        console.log('[FCM] Firebase Admin Initialized Successfully!');
    }
}catch(error){
    console.log('[FCM Error] Failed to initialize Firebase Admin SDK: ', error.message);
}

module.exports = admin;