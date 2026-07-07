
const db = require('../../../config/db')
const bycyrpt = require('bcryptjs');
const bcrypt = require('bcryptjs/dist/bcrypt');
const jwt = require('jsonwebtoken')

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

    async loginUser (username, password){
        const normalizedUsername = username.trim().toLowerCase();

        const findUserQuery = `
        SELECT id, username, phone_number, password_hash
        FROM users
        where username = $1;
        `;

        const result = await db.query(findUserQuery, [normalizedUsername]);

        if(result.rows.length == 0){
            throw new Error("Invalid Username or Password Credentials!");
        }

        const user = result.rows[0];

        const isPasswordValid = await bcrypt.compare(password, user.password_hash);

        if(!isPasswordValid){
            throw new Error ("Invalid Username or Password Credentials!");
        }

        // generate a signed, stateless Web Token
        // we store the user id inside the payload packet
        const tokenPayload = {
            id: user.id,
            username: user.username
        };

        const token = jwt.sign(tokenPayload, process.env.JWT_SECRET, {
            expiresIn: '30d'
        });

        return{
            user: {
                id: user.id,
                username: user.username,
                phone_number: user.phone_number
            },
            token
        };
    }
}

module.exports = new AuthService();