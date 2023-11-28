part of 'auth_bloc.dart';

// sealed class AuthEvent extends Equatable {
//   const AuthEvent();

//   @override
//   List<Object> get props => [];
// }

// class SignUpRequested extends AuthEvent {
//   final String email;
//   final String password;
//   final String name;
//   final PhoneAuthCredential phoneNumber;
//   SignUpRequested(this.email, this.password, this.name, this.phoneNumber);
// }

// class SignInRequest extends AuthEvent {
//   final String email;
//   final String password;
//   final BuildContext context;
//   SignInRequest(
//       {required this.email, required this.password, required this.context});
// }

// class LoginFormSubmitted extends AuthEvent {
//   final String email;
//   final String password;
//   final BuildContext context;

//   LoginFormSubmitted({
//     required this.email,
//     required this.password,
//     required this.context,
//   });

//   @override
//   List<Object> get props => [email, password, context];
// }

// class AuthenticationSuccess extends AuthEvent {}

// class LoginPasswordChanged extends AuthState {
//   final String password;
//   LoginPasswordChanged({required this.password});
// }

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object?> get props => [email, password, name];
}

class SignInRequest extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  SignInRequest({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object?> get props => [email, password, context];
}

class ForgetPassWordEvent extends AuthEvent {
  final String restetEmail;
  final BuildContext context;
  const ForgetPassWordEvent({required this.restetEmail, required this.context});
}

class SignupFailed extends AuthEvent {
  final String message;

  SignupFailed({required this.message});
}
