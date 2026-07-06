
import 'package:dio/dio.dart';
import '../../config/enviornment.dart';

class ApiClient {
  late final Dio dio;

  ApiClient(){
    dio = Dio(
      BaseOptions(
        baseUrl: Enviornment.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type':'application/json',
          'Accept': 'application/json'
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }
}