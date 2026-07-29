
const db = require('../../../config/db');

/**
 * Register or refresh an FCM token for a user device
 */
async function registerFcmToken(userId, fcmToken, deviceId){
    const query = `
        INSERT INTO user_fcm_tokens (user_id, fcm_token, device_id, updated_at)
        VALUES ($1, $2, $3, NOW())
        ON CONFLICT (user_id, device_id)
        DO UPDATE SET fcm_token = EXCLUDED.fcm_token, updated_at = NOW()
        RETURNING *;
    `;
    const {rows} = await db.query(query, [userId, fcmToken, deviceId]);
    return rows[0];
}

/**
 * Revoke an FCM token upon log out
 */
async function removeFcmToken(userId, deviceId){
    const query = `
        DELETE FROM user_fcm_tokens
        WHERE user_id = $1 AND device_id = $2
        RETURNING *;
    `;

    const {rows} = await db.query(query, [userId, deviceId]);
    return rows[0];
}

module.exports ={
    registerFcmToken,
    removeFcmToken
};