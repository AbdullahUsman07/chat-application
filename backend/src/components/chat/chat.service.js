
const db = require('../../../config/db');
const chatQueries = require('../../db/queries/chat.queries');
const presenceManager = require('../../sockets/presence.manager');

/**
 * Persists an incoming message packet into PostgreSQL and resolves target recipient socket IDs.
 * @param {Object} params
 * @param {number} params.roomId
 * @param {number} params.senderId
 * @param {string} params.payload
 * @returns {Promise<{ message: Object, recipientSockets: string[], recipientIds: number[] }>}
 */

async function processOutboundMessage({roomId, senderId, payload}){
    if(!roomId || !senderId ||!payload){
        throw new Error('Missing required message arguments: roomId, senderId, or payload.');
    }

    // 1. Asynchronous write to PostgreSQL message table
    const result = await db.query(chatQueries.insertMessage, [roomId, senderId, payload]);
    const savedMessage = result.rows[0];

    // 2. Fetch room members to identify participants
    const memeberResults = await db.query(chatQueries.getRoomMembers,[roomId]);
    // adding to diagnose broadcast error
    console.log('[DEBUG] Room Members from DB: ',memeberResults.rows);

    const recipentIds = memeberResults.rows
        .map(row => row.user_id)
        .filter(userId => userId !== parseInt (senderId, 10));
    console.log('[DEBUG] Filtered Recipient IDs: ',recipentIds);

    // 3. Query Redis for recipent socket sets across all active devices
    const recipientSockets = [];
    for(const recipentId of recipentIds){
        const sockets = await presenceManager.getUserSockets(recipentId);
        recipientSockets.push(...sockets); 
    }
    console.log('[DEBUG] Resolved Sockets from Redis: ',recipientSockets);
    return {
        message: savedMessage,
        recipientSockets,
        recipentIds
    };
}

/**
 * Function to retrieve an existing direct room ID between two users or create one on the fly.
 */
async function getOrCreateDirectRoom(userAId, userBId){
    const existing = await db.query(chatQueries.getDirectRoomBetweenUsers, [userAId, userBId]);
    if(existing.rows.length > 0){
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

module.exports ={
    processOutboundMessage,
    getOrCreateDirectRoom
};

