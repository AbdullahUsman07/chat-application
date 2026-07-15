
import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../auth/data/datasources/auth_local_datasource.dart';
import '../models/discovered_user_model.dart';

abstract class DiscoveryRemoteDataSource{
  Future<List<DiscoveredUserModel>> syncContacts(List<String> phoneNumbers);
}

class DiscoveryRemoteDataSourceImpl implements DiscoveryRemoteDataSource{
  final ApiClient apiClient;
  final AuthLocalDataSource authLocalDataSource;

  DiscoveryRemoteDataSourceImpl({
    required this.apiClient,
    required this.authLocalDataSource
  });

  @override   
  Future<List<DiscoveredUserModel>> syncContacts(List<String> phoneNumbers) async{

    final token = await authLocalDataSource.getToken();

    if(token == null){
      throw Exception('Unauthenticated: Access Token not found in Local Storage');
    }
    
    final response = await apiClient.dio.post(
      '/api/contacts/sync',
      data:{
        'phone_numbers': phoneNumbers
      },
      options: Options(  
        headers: {
          'Authorization': 'Bearer $token'
        }
      )
    );

    if (response.statusCode == 200 && response.data['success'] == true){
      final List<dynamic> dataList = response.data['data'] as List<dynamic>;
      return dataList.map((json) => DiscoveredUserModel.fromJson(json)).toList();
    }else{
      throw Exception(response.data['message'] ?? 'Failed to Sync Contacts');
    }
  }
}