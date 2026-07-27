
const redisClient = require('../../config/redis');

const getPresenceKey = (userId) => `user:${userId}:sockets`;

/**
 * Adds a socket ID to the user's active Redis socket set.
 * @param {string|number} userId
 * @param {string} socketId
 */

async function addSocket(userId, socketId) {
    if(!userId || !socketId) return;

    try{
        const key = getPresenceKey(userId);
        await redisClient.sadd(key, socketId);
        console.log(`[Presence] Added ${socketId} for User ${userId}`);
    }catch(error){
        console.error(`[Presence Error] Failed to Add socket for User ${userId}: `,error.message);
    }
}

/**
 * Removes a specific socket Id from the user's Redis Socket set.
 * @param {string |number} userId
 * @param {string} socketId
 */
async function removeSocket(userId, socketId){
    if(!userId || !socketId) return;

    try{
        const key = getPresenceKey(userId);
        await redisClient.srem(key, socketId);
        console.log(`[Presence] Remove socket ${socketId} for User ${userId}`);
    }catch(error){
        console.error(`[Presence Error] Failed to remove socket for User ${userId}: `,error.message);
    }
}

/**
 * Checks whether a user is online by inspecting active set cardinality (SCARD > 0).
 * @param {string | number} userId
 * @param {string} socketId
 */
async function isUserOnline(userId, socketId){
    if(!userId) return false;
    try{
        const key = getPresenceKey(userId);
        const count = await redisClient.scard(key);
        return count > 0;
    }catch(error){
        console.error(`[Presence Error] Failed to check status for User ${userId}`, error.message);
        return false;
    }
}

/**
 * Fetches all active socket IDs associated with a user across all devices.
 * @param {string |number} userId
 * @returns {Promise<string[]>}
 */
async function getUserSockets(userId){
    if(!userId) return [];
    try{
        const key = getPresenceKey(userId);
        return await redisClient.smembers(key);
    }catch(error){
        console.error(`[Presence Error] Failed to fetch sockets for User ${userId}: `, error.message);
        return [];
    }
}

module.exports ={
    addSocket,
    removeSocket,
    isUserOnline,
    getUserSockets
};