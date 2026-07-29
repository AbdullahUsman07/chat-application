
const db = require('../../../config/db'); 

/**
 * GET /api/rooms/:roomId/messages
 */
async function getRoomMessages(req, res) {
    try {
        const { roomId } = req.params;
        const { beforeId, limit = 30 } = req.query;
        const parsedLimit = Math.min(parseInt(limit, 10) || 30, 100);

        let query;
        let queryParams;

        if (beforeId) {
            query = `
                SELECT 
                    id AS "postgresId",
                    room_id AS "roomId",
                    sender_id AS "senderId",
                    payload,
                    status,
                    created_at AS "createdAt"
                FROM messages
                WHERE room_id = $1 AND id < $2
                ORDER BY id DESC
                LIMIT $3;
            `;
            queryParams = [roomId, beforeId, parsedLimit];
        } else {
            query = `
                SELECT 
                    id AS "postgresId",
                    room_id AS "roomId",
                    sender_id AS "senderId",
                    payload,
                    status,
                    created_at AS "createdAt"
                FROM messages
                WHERE room_id = $1
                ORDER BY id DESC
                LIMIT $2;
            `;
            queryParams = [roomId, parsedLimit];
        }

        const { rows } = await db.query(query, queryParams);

        const chronologicalMessages = rows.reverse();
        const nextCursor = chronologicalMessages.length > 0 ? chronologicalMessages[0].postgresId : null;

        return res.status(200).json({
            success: true,
            messages: chronologicalMessages,
            pagination: {
                hasMore: rows.length === parsedLimit,
                nextCursor: nextCursor
            }    
        });
    } catch (error) {
        console.error('[MESSAGE FETCH ERROR]: ', error.message);
        return res.status(500).json({ success: false, error: 'Failed to retrieve message history.' });
    }
}

/**
 * GET /api/rooms
 * Returns all active chat rooms for logged-in user with latest message preview & unread counts.
 */
async function getUserRooms(req, res) {
    try {
        const userId = req.user.id;
        const query = `
            SELECT 
                r.id AS "roomId",
                r.is_group AS "isGroup",
                r.created_at AS "createdAt",
                lm.id AS "lastMessageId",
                lm.payload AS "lastMessagePayload",
                lm.sender_id AS "lastMessageSenderId",
                lm.created_at AS "lastMessageTimestamp",
                COALESCE(unread.unread_count, 0)::INTEGER AS "unreadCount"
            FROM room_members rm
            JOIN rooms r ON r.id = rm.room_id
            LEFT JOIN LATERAL (
                SELECT id, payload, sender_id, created_at
                FROM messages
                WHERE room_id = r.id
                ORDER BY id DESC
                LIMIT 1
            ) lm ON true
            LEFT JOIN LATERAL (
                SELECT COUNT(*)::INTEGER AS unread_count
                FROM messages
                WHERE room_id = r.id
                    AND sender_id != $1
                    AND UPPER(status::text) != 'READ'
            ) unread ON true
            WHERE rm.user_id = $1
            ORDER BY COALESCE(lm.created_at, r.created_at) DESC;
        `;
        const { rows } = await db.query(query, [userId]);
        return res.status(200).json({
            success: true,
            rooms: rows
        });
    } catch (error) {
        console.error('[ROOM OVERVIEW ERROR]: ', error.message);
        return res.status(500).json({ success: false, error: 'Failed to retrieve room overview.' });
    }
}

module.exports = {
    getRoomMessages,
    getUserRooms   
};