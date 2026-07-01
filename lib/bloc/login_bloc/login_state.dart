abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  String error;
  LoginError(this.error);
}

class Success extends LoginState {}

class SignUpSuccess extends LoginState {
  String email;
  String name;
  SignUpSuccess(this.email, this.name);
}

class LogoutState extends LoginState {}
