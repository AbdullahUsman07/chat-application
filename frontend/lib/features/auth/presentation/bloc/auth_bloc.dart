
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{

  final AuthRemoteDataSource dataSource;

  AuthBloc({required this.dataSource}): super(AuthInitial()){
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async{
    emit(AuthLoading());

    try{
      final token = await dataSource.login(event.username, event.password);
      // TODO: Save token to secure storage here
      emit(AuthAuthenticated(token));
    }catch(e){
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignupRequested(SignupRequested event, Emitter<AuthState> emit) async{
    emit(AuthLoading());

    try{
      final token = await dataSource.signup(event.username, event.phoneNumber, event.password);
      // TODO: Save token to secure storage here
      emit(AuthAuthenticated(token));
    }catch(e){
      emit(AuthError(e.toString()));
    }
  }
}