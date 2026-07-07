
import 'package:dio/dio.dart';

class AuthRemoteDataSource{
  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  Future<String> login(String username, String password) async{
    try{
      final response = await dio.post('/api/auth/login', data:{
        'username': username,
        'password': password
      });

      final token = response.data['data']['token'] as String;
      return token;
    } on DioException catch(e){
      throw Exception(e.response?.data['message'] ?? 'Login Failed');
    }
  }

  Future<String> signup(String username, String phoneNumber, String password) async{

    try{
      final response = await dio.post('/api/auth/signup', data: {
        'username' : username,
        'phone_number': phoneNumber,
        'password': password
      });

      print("DEBUG: Raw Response Data Type: ${response.data.runtimeType}");
      print("DEBUG: Raw Response Body: ${response.data}");
      return response.data['token'];
    } on DioException catch (e){

      throw Exception(e.response?.data['message'] ?? 'Signup Failed');
    }
  }
}