

abstract class AuthEvent {}

class LoginRequested extends AuthEvent{
  final String username;
  final String password;

  LoginRequested(this.username, this.password);
}

class SignupRequested extends AuthEvent{
  final String username;
  final String phoneNumber;
  final String password;

  SignupRequested(this.username, this.phoneNumber, this.password);
}