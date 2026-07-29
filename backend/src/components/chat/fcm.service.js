
const admin = require('../../../config/firebase');
const db = require('../../../config/db');

/**
 * Send high-priority FCM push notifications to all active devices of an offline recipient
 * Automatically prunes stale or unregistered tokens from PostgreSQL
 * 
 * @param {Object} params
 * @param {number|string} params.recipientId
 * @param {number|string} params.senderId
 * @param {number|string} params.roomId
 * @param {number|string} params.postgresId  
 * @param {string} params.contentSnippet
 */

async function sendPushNotification({ recipientId, senderId, roomId, postgresId, contentSnippet }) {
    try {

        // 1. fetch active FCM tokens from recipient from user_fcm_tokens
        const query = `
            SELECT fcm_token, device_id
            FROM user_fcm_tokens
            WHERE user_id = $1;
        `;
        const { rows } = await db.query(query, [recipientId]);

        if (!rows || rows.length == 0) {
            console.log(`[FCM LOG] No FCM tokens registered for user ${recipientId}. Skipping push`);
            return;
        }

        const tokens = rows.map(r => r.fcm_token);

        // 2. Construct a high-priority FCM payload 
        const messagePayload = {
            tokens: tokens,
            notification: {
                title: 'New Message',
                body: contentSnippet && contentSnippet.length > 100
                    ? `${contentSnippet.substring(0, 97)}...`
                    : (contentSnippet || 'You recieved a message'),
            },
            data: {
                roomId: String(roomId),
                senderId: String(senderId),
                messageId: String(postgresId),
                type: 'CHAT_MESSAGE',
                click_action: 'FLUTTER_NOTIFICATION_CLICK',
            },
            android: {
                priority: 'high',
                notification: {
                    channelId: 'chat_messages',
                    priority: 'max',
                    defaultSound: true,
                },
            },
            apns: {
                payload: {
                    aps: {
                        sound: 'default',
                        contentAvailable: true,
                    }
                }
            }
        }

        // 3. dispatch multicast push via Firebase Admin SDK
        const response = await admin.messaging().sendEachForMulticast(messagePayload);
        console.log(`[FCM SERVICE] Multicast dispatched for User ${recipientId}. Successes ${response.successCount}, Failures: ${response.failureCount}`);

        // 4. Stale token pruning engine
        if (response.failureCount > 0) {
            const failedTokens = [];

            response.responses.forEach((resp, idx) => {
                if (!resp.success) {
                    const errorCode = resp.error ? resp.error.code : '';
                    console.warn(`[FCM SERVICE WARNING] Token at index ${idx} failed: ${errorCode}`);

                    if (
                        errorCode === 'messaging/invalid-registration-token' ||
                        errorCode === 'messaging/registration-token-not-registered'
                    ) {
                        failedTokens.push(tokens[idx]);
                    }
                }
            });
            if (failedTokens.length > 0) {
                console.log(`[FCM SERVICE PRUNING] Purging ${failedTokens.length} stale token(s) from PostgreSQL...`);
                await pruneStaleTokens(recipientId, failedTokens);
            }
        }
    } catch (error) {
        console.error(`[FCM SERVICE ERROR] Failed to process push notification for user ${recipientId}:`, error.message);
    }
}

/**
 * Removed invalid or revoked FCM tokens from the user_fcm_tokens table in batch.
 * 
 * @param {number|string} userId  
 * @param {string[]} tokens
 */
async function pruneStaleTokens(userId, tokens) {
    try {
        const deleteQuery = `
            DELETE FROM user_fcm_tokens
            WHERE user_id = $1 AND fcm_token = ANY($2::text[]);
        `;
        const result = await db.query(deleteQuery, [userId, tokens]);
        console.log(`[FCM SERVICE PRUNING SUCCESS] Removed ${result.rowCount} stale token(s) for user ${userId}`);
    }catch(error){
        console.error(`[FCM SERVICE PRUNING ERROR] Failed to purge tokens for user ${userId}:`, err.message);
    }
}

module.exports = {
    sendPushNotification,
    pruneStaleTokens
}