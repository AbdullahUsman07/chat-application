
import 'package:get_it/get_it.dart';
import 'core/network/api_client.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';


final sl = GetIt.instance;

void init(){
  
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(dio: sl<ApiClient>().dio),
    );

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(dataSource: sl<AuthRemoteDataSource>()),
  );
}