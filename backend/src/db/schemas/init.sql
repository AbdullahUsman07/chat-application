-- Enable the Trigram extension for ultra-fast partial string matching on handles
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- 1. Identity & Profiles Table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(30) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Optimize phone lookup (WhatsApp flow) and username search (Telegram flow)
CREATE INDEX IF NOT EXISTS idx_users_phone ON users(phone_number);
CREATE INDEX IF NOT EXISTS idx_users_username_trgm ON users USING gin (username gin_trgm_ops);

-- 2. Directional Contacts Junction Table
CREATE TABLE IF NOT EXISTS contacts (
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    contact_user_id INT REFERENCES users(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, contact_user_id)
);

-- 3. Room Management Table
CREATE TABLE IF NOT EXISTS rooms (
    id SERIAL PRIMARY KEY,
    is_group BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Room Members Authorization Table
CREATE TABLE IF NOT EXISTS room_members (
    room_id INT REFERENCES rooms(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    PRIMARY KEY (room_id, user_id)
);

-- 5. Write-Heavy Messages Ledger Table
CREATE TABLE IF NOT EXISTS messages (
    id BIGSERIAL PRIMARY KEY,
    room_id INT REFERENCES rooms(id) ON DELETE CASCADE,
    sender_id INT REFERENCES users(id) ON DELETE SET NULL,
    payload TEXT NOT NULL,
    status VARCHAR(10) DEFAULT 'sent', -- Lifecycle states: 'sent', 'delivered', 'read'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexing for low-latency cursor pagination when loading a chat screen
CREATE INDEX IF NOT EXISTS idx_messages_room_datetime ON messages(room_id, created_at DESC);