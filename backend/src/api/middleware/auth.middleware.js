
const jwt = require('jsonwebtoken')
require('dotenv').config();


/**
 *  This is Express Middleware to protect private REST resources
 *  Expects an HTTP header format of : Authorization: Bearer <Token>
 */

const authenticateToken = (req,res,next) => {

    const authHeader = req.headers['authorization'];

    // this header will be looking like this "Bearer eyJhbGciOi..."
    // we split the space to just take the token 
    const token = authHeader && authHeader.split(' ')[1];

    if(!token){
        return res.status(401).json({
            success: false,
            message: 'Access Denied. Authorization Token missing from request headers.'
        });
    }

    try{
        const decodedPayLoad = jwt.verify(token, process.env.JWT_SECRET);

        req.user = {
            id: decodedPayLoad.id,
            username: decodedPayLoad.username
        };

        next();
    }catch(error){
        return res.status(403).json({
            success:false,
            message: 'Access Forbidden. Provided authorization token is invlaid or expired!'
        });
    }
}

module.exports = authenticateToken;