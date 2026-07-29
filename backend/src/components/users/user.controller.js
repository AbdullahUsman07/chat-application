
const userService = require('./user.service');

async function handleRegisterFcmToken (req,res){
    try{
        const userId = req.user.id; //check this
        const {fcmToken, deviceId} = req.body;

        if(!fcmToken || !deviceId){
            return res.status(400).json({error: 'fcmToken and deviceId are required.'});
        }

        const record = await userService.registerFcmToken(userId, fcmToken, deviceId);
        return res.status(200).json({status: 'ok', data: record});
    }catch(error){
        console.error('[FCM API ERROR] Error saving FCM token: ', error);
        return res.status(500).json({error: 'Internal Server Error. '});
    }
}

async function handleRemoveFcmToken(req, res){
    try{
        const userId = req.user.id;
        const { deviceId } = req.body;

        if(!deviceId){
            return res.status(400).json({error: 'deviceId is required.'});
        }

        await userService.removeFcmToken(userId, deviceId);
        return res.status(200).json({status: 'ok', message: 'Token Revoked Successfully'});
    }catch(error){
        console.error('[FCM API ERROR] Error revoking FCM token: ', error);
        return res.status(500).json({error: 'Internal Server Error'});
    }
}

module.exports = {
    handleRegisterFcmToken,
    handleRemoveFcmToken
};