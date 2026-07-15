class PhoneSanitizer{

  static String sanitize(String rawNumber, {String defaultCountryCode='+92'}){
    
    // Strip everything but the number and leading '+' sign
    String cleaned = rawNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    if(cleaned.isEmpty){
      return '';
    }

    if(cleaned.startsWith('+')){
      return cleaned;
    }
    
    // converting international double-zero prefixes (e.g., 0092.. to +92..)
    if(cleaned.startsWith('00')){
      return '+' + cleaned.substring(2);
    }

    final formattedCountryCode = defaultCountryCode.startsWith('+')
    ? defaultCountryCode 
    : '+$defaultCountryCode';

    // strip local leading 0 (e.g., '0301...' to '301') and prepend country code
    if(cleaned.startsWith('0')){
      return '$formattedCountryCode${cleaned.substring(1)}';
    }

    return '$formattedCountryCode$cleaned';
  }

}