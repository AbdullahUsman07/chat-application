const contactsService = require('./contacts.service');
const ContactService = require('./contacts.service');

class ContactsController{

    async sync(req, res){

        try{
            const {phone_numbers} = req.body;
            const userId = req.user.id;

            // validation to ensure poyload is an array to prevent sql injection
            if(!Array.isArray(phone_numbers)){
                return res.status(400).json({
                    success: false,
                    message: 'Invalid Payload! phone_numbers must be an array!'
                });
            }

            const matchedContacts = await contactsService.syncContacts(userId, phone_numbers);

            return res.status(200).json({
                success: true,
                message: `Sucessfully Synchronized ${matchedContacts.length} contacts`,
                data: matchedContacts
            });
        }catch(error){
            return res.status(500).json({
                success: false,
                message: 'An error occured during contact synchronization'
            });
        }
    }
}

module.exports = new ContactsController();