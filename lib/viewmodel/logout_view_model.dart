import 'package:acl/utils/routes/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      await Utils().clear();
      print('User logged out successfully');
    } catch (e) {
      print('Error while logging out: $e');
    }
  }
}
