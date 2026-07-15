
import '../../domain/repositories/discovery_repository.dart';
import '../datasources/contact_local_data_source.dart';
import '../datasources/discovery_remote_data_source.dart';
import '../models/discovered_user_model.dart';

class DiscoveryRepositoryImpl implements DiscoveryRepository{
  final ContactLocalDataSource localDataSource;
  final DiscoveryRemoteDataSource remoteDataSource;

  DiscoveryRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource
  });

  @override   
  Future<List<DiscoveredUserModel>> syncDeviceContacts() async{

    final localNumbers = await localDataSource.getSanitizedPhoneNumbers();

    if(localNumbers.isEmpty){
      return [];
    }

    return await remoteDataSource.syncContacts(localNumbers);
  }
}