abstract class AuthEvent {}

class AppStarted extends AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent(this.email, this.password);
}

class LogoutEvent extends AuthEvent {}
