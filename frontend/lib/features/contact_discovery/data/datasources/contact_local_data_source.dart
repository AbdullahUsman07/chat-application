

import 'package:flutter_contacts/flutter_contacts.dart';
import '../utils/phone_sanitizer.dart';


abstract class ContactLocalDataStore{
  Future <List<String>> getSanitizedPhoneNumbers({String defaultCountryCode ='+92'});
}

class ContactLocalDataStoreImpl implements ContactLocalDataStore{
  @override
  Future<List<String>> getSanitizedPhoneNumbers({String defaultCountryCode ='+92'}) async{

    final contacts = await FlutterContacts.getAll(
      properties: {ContactProperty.name, ContactProperty.phone}
    );

    final Set<String> uniqueSanitizedNumbers = {};

    for(final contact in contacts){
      for(final phone in contact.phones){
        final rawNumber = phone.number;
        final sanitizedNumber = PhoneSanitizer.sanitize(
          rawNumber,
          defaultCountryCode: defaultCountryCode
        );

        if(sanitizedNumber.isNotEmpty){
          uniqueSanitizedNumbers.add(sanitizedNumber);
        }
      }
    }

    return uniqueSanitizedNumbers.toList();
  }
}