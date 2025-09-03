import 'package:acl/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  // Password validation
  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<void> reauthenticateAndChangePassword(
    String oldPassword,
    String newPassword,
    String confirmPassword,
    BuildContext context,
  ) async {
    if (oldPassword.trim().isEmpty ||
        newPassword.trim().isEmpty ||
        confirmPassword.trim().isEmpty) {
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
      clearMessages();
      Navigator.pushNamed(context, RoutesName.settings);
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

  // Validation methods
  String? validateOldPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Current password is required';
    }
    return null;
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'New password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
}
