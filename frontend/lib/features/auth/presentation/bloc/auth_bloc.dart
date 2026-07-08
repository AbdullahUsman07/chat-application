
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/features/auth/data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{

  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthBloc({
    required this.remoteDataSource,
    required this.localDataSource,
    }): super(AuthInitial()){
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async{
    emit(AuthLoading());

    try{
      final token = await remoteDataSource.login(event.username, event.password);
      
      await localDataSource.saveToken(token);

      emit(AuthAuthenticated(token));
    }catch(e){
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignupRequested(SignupRequested event, Emitter<AuthState> emit) async{
    emit(AuthLoading());

    try{
      final token = await remoteDataSource.signup(event.username, event.phoneNumber, event.password);
      
      await localDataSource.saveToken(token);
      
      emit(AuthAuthenticated(token));
    }catch(e){
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async{
    try{

      await localDataSource.clearToken();

      emit(AuthInitial());
    }catch(e){
      emit(AuthError('Failed to Logout! ${e.toString()}'));
    }
  }
}