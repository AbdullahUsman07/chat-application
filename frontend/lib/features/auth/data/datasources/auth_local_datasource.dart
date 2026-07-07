
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  static const String _tokenKey = 'auth_jwt_token';

  AuthLocalDataSource({required this.secureStorage});

  Future<void> saveToken(String token) async{
    await secureStorage.write(key: _tokenKey, value: token);
  }

  Future<String?> getToken() async{
    return await secureStorage.read(key: _tokenKey);
  }

  Future<void> clearToken() async{
    await secureStorage.delete(key: _tokenKey);
  }

}