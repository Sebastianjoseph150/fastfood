// ignore_for_file: empty_catches

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fastfood/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final GlobalKey<ScaffoldMessengerState>? scaffoldKey; // Add a GlobalKey

  AuthBloc({required this.authRepository, this.scaffoldKey})
      : super(UnAuthenicated()) {
    on<ForgetPassWordEvent>(forgetPassWordEvent);
    on<SignUpRequested>(signUpRequested);
    on<SignInRequest>(signInRequest);
  }
  // Check for saved authentication state
  // Future<void> checkAuthentication() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
  //   if (isAuthenticated) {
  //     emit(Authenticated());
  //   }
  // }

  FutureOr<void> forgetPassWordEvent(
      ForgetPassWordEvent event, Emitter<AuthState> emit) {
    try {
      emit(ForgetPasswordState(resetEmail: event.restetEmail));
      authRepository.resetPassword(
          email: event.restetEmail, context: event.context);
    } catch (e) {}
  }

  FutureOr<void> signUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      final UserCredential? isregistres = await authRepository.signUp(
          email: event.email,
          password: event.password,
          // phoneAuthCredential: event.phoneNumber,
          userName: event.name);

      if (isregistres != null) {
        emit(SignUpSuccess(Successmessaage: 'new user Successfully registerd'));
      } else {
        emit(SignUpFailure(errorMessge: 'Sign up failed check your details'));
      }
    } catch (e) {}
  }

  FutureOr<void> signInRequest(
      SignInRequest event, Emitter<AuthState> emit) async {
    emit(Loading());
    try {
      final isAuthenticated = await authRepository.signIn(
        email: event.email,
        password: event.password,
      );

      if (isAuthenticated != null) {
        emit(SignInSuccess(SuccessMessage: 'User Logined'));
      } else {
        emit(LoginfailedState(
            e: 'failed to login check your email and password'));
      }
    } catch (e) {}
  }
}
