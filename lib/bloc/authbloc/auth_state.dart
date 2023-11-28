part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class Loading extends AuthState {
  @override
  List<Object> get props => [];
}

class UnAuthenicated extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginState extends Equatable {
  final String email;
  final String password;

  const LoginState({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignUpSuccess extends AuthState {
  final String Successmessaage;

  SignUpSuccess({required this.Successmessaage});
}

class SignUpFailure extends AuthState {
  final String errorMessge;

  SignUpFailure({required this.errorMessge});
}

class SignInSuccess extends AuthState {
  final String SuccessMessage;

  SignInSuccess({required this.SuccessMessage});
}

class SignInFailure extends AuthState {
  final String SigninerrorMessge;

  SignInFailure({required this.SigninerrorMessge});
}

// class LoginSuccess extends AuthState {}

// class LoginFailure extends AuthState {}

class AuthenticationError extends AuthState {
  final String errorMessage;

  const AuthenticationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class LoginfailedState extends AuthState {
  final String e;

  LoginfailedState({required this.e});
}

class Authenticated extends AuthState {
  // You can include user information or tokens here if needed
}

class ForgetPasswordState extends AuthState {
  final String resetEmail;

  ForgetPasswordState({required this.resetEmail});
}
