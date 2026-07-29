
const db = require('../../../config/db');
const chatQueries = require('../../db/queries/chat.queries');
const presenceManager = require('../../sockets/presence.manager');
const fcmService = require('./fcm-service');

/**
 * Persists an incoming message packet into PostgreSQL and resolves target recipient socket IDs.
 * @param {Object} params
 * @param {number} params.roomId
 * @param {number} params.senderId
 * @param {string} params.payload
 * @returns {Promise<{ message: Object, recipientSockets: string[], recipientIds: number[] }>}
 */

async function processOutboundMessage({ roomId, senderId, payload }) {
    if (!roomId || !senderId || !payload) {
        throw new Error('Missing required message arguments: roomId, senderId, or payload.');
    }

    // 1. Asynchronous write to PostgreSQL message table
    const result = await db.query(chatQueries.insertMessage, [roomId, senderId, payload]);
    const savedMessage = result.rows[0];

    // 2. Fetch room members to identify participants
    const memeberResults = await db.query(chatQueries.getRoomMembers, [roomId]);
    // adding to diagnose broadcast error
    console.log('[DEBUG] Room Members from DB: ', memeberResults.rows);

    const recipentIds = memeberResults.rows
        .map(row => row.user_id)
        .filter(userId => userId !== parseInt(senderId, 10));
    console.log('[DEBUG] Filtered Recipient IDs: ', recipentIds);

    // 3. Query Redis for recipent socket sets & categorize online vs offline users
    const recipientSockets = [];
    const offlineRecipientIds = [];

    for (const recipentId of recipentIds) {
        const sockets = await presenceManager.getUserSockets(recipentId);
        if (sockets && sockets.length > 0) {
            // recipient has active socket connection(s).
            recipientSockets.push(...sockets);
        }
        else {
            // recipient has 0 socket connection (meaning offline/backgrounded).
            offlineRecipientIds.push(recipentId);

            // trigger FCM push for offline users
            try{
                await fcmService.sendPushNotification({
                    recipentId,
                    senderId,
                    roomId,
                    postgresId: savedMessage.id,
                    contentSnipped: payload
                });
                console.log(`[ROUTER] Dispatched FCM push to offline recipiet: ${recipentId}`);
            }catch(pushErr){
                console.error(`[ROUTER] FCM push trigger failed for recpient ${recipentId}: `, pushErr.message);
            }
        }
    }
    console.log('[DEBUG] Resolved Sockets from Redis: ', recipientSockets);
    console.log('[DEBUG] Offline recipients routes to FCM: ',offlineRecipientIds);
    return {
        message: savedMessage,
        recipientSockets,
        recipentIds,
        offlineRecipientIds
    };
}

/**
 * Function to retrieve an existing direct room ID between two users or create one on the fly.
 */
async function getOrCreateDirectRoom(userAId, userBId) {
    const existing = await db.query(chatQueries.getDirectRoomBetweenUsers, [userAId, userBId]);
    if (existing.rows.length > 0) {
        return existing.rows[0].room_id || exisitng.rows[0].id;
    }

    // create Room
    const roomResult = await db.query(chatQueries.createRoom, [false]);
    const roomId = roomResult.rows[0].id;

    // attach both users as Room Members
    await db.query(chatQueries.addRoomMember, [roomId, userAId]);
    await db.query(chatQueries.addRoomMember, [roomId, userBId]);

    return roomId;
}


/**
 * Marks all unread messages in a room for a specific user as 'read'
 */
async function markRoomAsRead(roomId, recipientUserId) {
    const results = await db.query(chatQueries.markRoomMessagesAsRead, [roomId, recipientUserId]);
    return results.rows;
}

/**
 * Mark an array of messsage IDs as 'delivered' in batch
 */
async function markMessagesDeliveredBatch(messageIds) {
    if (!messageIds || messageIds.length == 0) return [];

    // ensure array format even if a singleID string/number is passed
    const idArray = Array.isArray(messageIds) ? messageIds : [messageIds];

    const result = await db.query(chatQueries.markMessagesDeliveredBatch, [messageIds]);
    return result.rows;
}



module.exports = {
    processOutboundMessage,
    getOrCreateDirectRoom,
    markRoomAsRead,
    markMessagesDeliveredBatch
};

