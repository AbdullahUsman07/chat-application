
const db = require('../../../config/db')
const contactQueries = require('../../db/queries/contacts.queries')

class ContactService{

    /**
   * Synchronizes an array of raw phone numbers with the database.
   * @param {number} currentUserId - The ID of the user making the request
   * @param {string[]} phoneNumbersArray - Array of E.164 phone number strings
   * @returns {Promise<Array>} List of matched user profiles
   */

    async syncContacts(currentUserId, phoneNumbersArray){

        const matchResult = await db.query(contactQueries.matchPhones, [phoneNumbersArray, currentUserId]);
        const matchedUsers = matchResult.rows;

        if(matchedUsers.length == 0){
            return [];
        }

        const matchedIds = matchedUsers.map(user => user.id);

        await db.query(contactQueries.addRelations, [currentUserId, matchedIds]);

        return matchedUsers;
    }

    async searchUsers(currentUserId, searchQuery){
        const sanitizedQuery = searchQuery
      .trim()
      .replace(/%/g, '\\%')
      .replace(/_/g, '\\_');

        const formattedQuery = `%${sanitizedQuery}%`; 

        const results = await db.query(contactQueries.searchGlobalUsers, [formattedQuery, currentUserId]);
        return results.rows;
    }
}

module.exports = new ContactService();