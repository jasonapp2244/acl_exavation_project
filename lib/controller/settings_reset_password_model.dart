import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // Password validation
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<void> reauthenticateAndChangePassword(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    if (oldPassword.trim().isEmpty || newPassword.trim().isEmpty || confirmPassword.trim().isEmpty) {
      _errorMessage = "All fields are required";
      _successMessage = null;
      notifyListeners();
      return;
    }

    if (!_isValidPassword(newPassword)) {
      _errorMessage = "Password must be at least 6 characters long";
      _successMessage = null;
      notifyListeners();
      return;
    }

    if (newPassword != confirmPassword) {
      _errorMessage = "New password and confirm password do not match";
      _successMessage = null;
      notifyListeners();
      return;
    }

    if (oldPassword == newPassword) {
      _errorMessage = "New password must be different from old password";
      _successMessage = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null || user.email == null) {
        _errorMessage = "No user found. Please login again.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      print("Re-authenticating for user: ${user.email}");

      // Build credential with current email and old password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      // Re-authenticate - FIXED: Uncommented this critical line!
      await user.reauthenticateWithCredential(credential);
      print('Re-authentication successful');

      // Update password
      await user.updatePassword(newPassword);
      _successMessage = "Password changed successfully!";
      _errorMessage = null;
      
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          _errorMessage = "Current password is incorrect";
          break;
        case 'weak-password':
          _errorMessage = "Password is too weak. Choose a stronger password";
          break;
        case 'requires-recent-login':
          _errorMessage = "Please login again to change your password";
          break;
        default:
          _errorMessage = "Failed to change password: ${e.message}";
      }
      _successMessage = null;
    } catch (e) {
      _errorMessage = "An unexpected error occurred";
      _successMessage = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
}
