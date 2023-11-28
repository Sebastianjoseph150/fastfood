import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    // if (email.isEmpty || password.isEmpty || userName.isEmpty) {
    //   return null;
    // }

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(userName);
      }

      return userCredential;
    } catch (e) {
      return null;
    }
  }

  Future<void> resetPassword(
      {required String email, required BuildContext context}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      _showResetPasswordSuccessDialog(context);
    } catch (e) {
      rethrow;
    }
  }

  void _showResetPasswordSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Reset'),
          content: const Text('Please check your email to reset the password.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential; // Return UserCredential if sign-in is successful
    } catch (e) {
      return null; // Return null if sign-in fails
    }
  }
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class WeakPasswordException extends AuthException {
  WeakPasswordException() : super('This password is too weak.');
}

class EmailInUseException extends AuthException {
  EmailInUseException() : super('The account is already in use.');
}

class UserNotFoundException extends AuthException {
  UserNotFoundException() : super('No user found for that email.');
}

class WrongPasswordException extends AuthException {
  WrongPasswordException() : super('Wrong password provided for that user.');
}
