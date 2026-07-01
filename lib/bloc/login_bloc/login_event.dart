abstract class LoginEvent {}

class Login extends LoginEvent {
  String email;
  String password;
  Login(this.email, this.password);
}

class SignUp extends LoginEvent {
  String name;
  String email;
  String password;
  SignUp(this.name, this.email, this.password);
}

class Logout extends LoginEvent {}
