import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeEmailModelView extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  // Email validation
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> changeEmail(String newEmail) async {
    if (newEmail.trim().isEmpty) {
      _errorMessage = "Email cannot be empty";
      _successMessage = null;
      notifyListeners();
      return;
    }

    if (!_isValidEmail(newEmail)) {
      _errorMessage = "Please enter a valid email address";
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

      if (user == null) {
        _errorMessage = "No user found. Please login again.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      if (!user.emailVerified) {
        await user.sendEmailVerification();
        _errorMessage =
            "Please verify your current email before changing it. Verification email sent.";
        _isLoading = false;
        notifyListeners();
        return;
      }

      // Proceed to change email
      await user.updateEmail(newEmail);
      _successMessage = "Email updated successfully!";
      _errorMessage = null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          _errorMessage = "This email is already in use by another account";
          break;
        case 'invalid-email':
          _errorMessage = "Invalid email address";
          break;
        case 'requires-recent-login':
          _errorMessage = "Please login again to change your email";
          break;
        default:
          _errorMessage = "Failed to update email: ${e.message}";
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
