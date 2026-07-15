
import 'package:frontend/features/contact_discovery/presentation/bloc/contact_permission_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'core/network/api_client.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/data/datasources/auth_local_datasource.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/contact_discovery/data/datasources/contact_local_data_source.dart';


final sl = GetIt.instance;

void init(){
  
  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(dio: sl<ApiClient>().dio),
    );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(secureStorage: sl<FlutterSecureStorage>()),
  );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      localDataSource: sl<AuthLocalDataSource>()),
  );

  sl.registerFactory(() => ContactPermissionBloc());

  sl.registerLazySingleton<ContactLocalDataStore>(() => ContactLocalDataStoreImpl());
}