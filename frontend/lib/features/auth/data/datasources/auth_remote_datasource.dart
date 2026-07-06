
import 'package:dio/dio.dart';

class AuthRemoteDataSource{
  final Dio dio;

  AuthRemoteDataSource({required this.dio});

  Future<String> login(String password, String username) async{
    try{
      final response = await dio.post('/auth/login', data:{
        'username': username,
        'password': password
      });

      return response.data['token'];
    } on DioException catch(e){
      throw Exception(e.response?.data['message'] ?? 'Login Failed');
    }
  }

  Future<String> signup(String username, String phoneNumber, String password) async{

    try{
      final response = await dio.post('/auth/signup', data: {
        'username' : username,
        'phone_number': phoneNumber,
        'password': password
      });

      return response.data['token'];
    } on DioException catch (e){

      throw Exception(e.response?.data['message'] ?? 'Signup Failed');
    }
  }
}