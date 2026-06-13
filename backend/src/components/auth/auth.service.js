
const db = require('../../../config/db')
const bycyrpt = require('bcryptjs')

class AuthService {

    /**
     * @param {string} username - Unique handle chosen by the user
     * @param {string} password - Raw plain-text password from the request
     * @param {string} phone_number - E.164 standardized phone number
     */

    async register_user(username, phone_number, password) {

        const normalized_username = username.trim().toLowerCase();
        const normalized_phone = phone_number ? phone_number.trim() : null;

        // query to check existing conflicts in the database
        const checkUserQuery = `
        select username, phone_number FROM users
        where username = $1 OR (phone_number = $2 AND $2 IS NOT NULL);
        `;

        const existingUsers = await db.query(checkUserQuery, [normalized_username, normalized_phone]);

        if (existingUsers.rows.length > 0) {
            const conflict = existingUsers.rows[0];
            if (conflict.username == normalized_username) {
                throw new Error('Username has already been taken!');
            }
            if (conflict.phone_number == normalized_phone) {
                throw new Error('Phone Number is already registered!');
            }
        }

        // generating salts and computing hash
        const salt = await bycyrpt.genSalt(10);
        const passwordHash = await bycyrpt.hash(password, salt);

        const insertUserQuery = `
        INSERT INTO users (username, phone_number, password_hash)
        VALUES  ($1, $2, $3)
        RETURNING id, username, phone_number, created_at;
        `;

        const result = await db.query(insertUserQuery,
            [normalized_username,
            normalized_phone,
            passwordHash
            ]);

            return result.rows[0];
    }
}

module.exports = new AuthService();