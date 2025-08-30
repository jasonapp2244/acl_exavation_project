import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  // Getters

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future forgotPassword({required String email, BuildContext? context}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Navigator.pop(context!);
    } on FirebaseAuthException catch (err) {
      throw Exception(err.message.toString());
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
