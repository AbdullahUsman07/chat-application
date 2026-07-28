
module.exports = {

    createRoom : `
        INSERT INTO rooms (is_group)
        VALUES ($1)
        RETURNING id, is_group, created_at;
    `,

    addRoomMember: `
        INSERT INTO room_members (room_id, user_id)
        VALUES ($1, $2)
        ON CONFLICT DO NOTHING;
    `,

    getDirectRoomBetweenUsers: `
        SELECT rm1.room_id AS room_id
        FROM room_members rm1
        JOIN room_members rm2 ON rm1.room_id = rm2.room_id
        JOIN rooms r ON r.id = rm1.room_id
        WHERE rm1.user_id = $1 AND rm2.user_id = $2 AND r.is_group = FALSE;
    `,

    getRoomMembers: `
        SELECT user_id
        FROM room_members
        WHERE room_id = $1;
    `,

    insertMessage: `
        INSERT INTO messages (room_id, sender_id, payload, status)
        VALUES ($1, $2, $3, 'sent')
        RETURNING id, room_id, sender_id, payload, status, created_at;
    `,

    getMessageByClientUuid: `
        SELECT id, room_id, sender_id, payload, status, created_at
        FROM messages
        WHERE client_uuid = $1;
    `,

    // Bulk update unread messages in a room to 'read'
    markRoomMessagesAsRead: `
        UPDATE messages
        SET status = 'read'
        WHERE room_id = $1 AND sender_id != $2 AND status != 'read'
        RETURNING id, room_id, sender_id, status;
    `,

    markMessagesDeliveredBatch: `
        UPDATE messages
        SET status = 'delivered'
        WHERE id = ANY($1::bigint[]) AND status = 'sent'
        RETURNING id, room_id, sender_id, status;
    `,
}