

module.exports = {
    /**
     * Matches the array of phone numbers against the registered users
     * Exclude's the user id so they won't add themselves as contact
     */

    matchPhones: `
    SELECT id, username, phone_number
    FROM users
    WHERE phone_number = ANY($1::varchar[]) AND id != $2;
    `,

    addRelations:  `
    INSERT INTO contacts (user_id, contact_user_id)
    SELECT $1, unnest($2::int[])
    ON CONFLICT (user_id, contact_user_id) DO NOTHING;
    `,

    searchGlobalUsers: `
    SELECT id, username, created_at
    FROM users
    WHERE LOWER(username) LIKE LOWER($1) AND id != $2
    LIMIT 20;
    `
}