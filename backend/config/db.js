
const {Pool} = require('pg')
require('dotenv').config();

const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
});

pool.on('connect', ()=>{
    console.log('PostgreSQL Database connection pool established')
});

pool.on('error',(err)=>{
    console.error('Unexpected Error or Idle Postgres Client: ',err)
    process.exit(-1);
});

module.exports = {
    query: (text, params) => pool.query(text, params),
    pool,
};