
const authService = require('./auth.service')

class AuthController{

    async signup(req, res){
        try{
            const {username, phone_number, password} = req.body;

            if(!username || !password){
                return res.status(400).json({
                    success: false,
                    message: 'Username and Password feilds are strictly required'
                });
            }

            const newUser = authService.register_user(username, phone_number, password);

            return res.status(201).json({
                success: true,
                message: 'User Account Created Successfully!',
                data:{
                    id: newUser.id,
                    username: newUser.username,
                    phone_number: newUser.phone_number,
                    created_at: newUser.created_at
                }
            });
        } catch(error){
            return res.status(409).json({
                success: false,
                message: error.message || 'An internal Validation Error Occured during Signup!'
            });
        }
    }


    async login(req, res){
        try{
            const {username, passowrd} = req.body;

            if(!username || !password){
                return res.status(400).json({
                    success: false,
                    message: 'Username and Password are required'
                });
            }

            const authData = await authService.login(username, password);

            return res.status(200).json({
                success: true,
                message: 'Authentication Successful!',
                data: authData
            });

        }catch(error){
            res.status(200).json({
                success: false,
                message: error.message || 'Authentication Failed!'
            });
        }
    }
}

module.exports = new AuthController();