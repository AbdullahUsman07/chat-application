
const Redis = require('ioredis');

const redisHost = process.env.REDIS_HOST || '127.0.0.1';
const redisPort = process.env.REDIS_PORT || 6379 ;

let redisClient = null;

try{
    // instantiate the client with an explicit reconnection strategy

    redisClient = new Redis({
        host: redisHost,
        port: parseInt(redisPort,10),
        retryStrategy(times){
            const delay = Math.min(times * 50, 2000);
            console.warn (`[Redis] Connection broken. Retrying in ${delay}ms.... (Attempt ${times})`);
            return delay;
        },
        maxRetriesPerRequest: null,
    });

    redisClient.on('connect', () =>{
        console.log(`[Redis] connected Successfully to ${redisHost}:${redisPort}`);
    });

    redisClient.on('error', (err)=>{
        console.error('[Redis] Client Database Error: ',err.message);
    });
} catch (error){
    console.error('[Redis] Initialization Failure occured: ',error);
}

module.exports = redisClient;