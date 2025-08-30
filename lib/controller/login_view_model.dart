import 'package:acl/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginViewModel extends ChangeNotifier {
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  String get email => _email;
  String get password => _password;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Setters
  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  // Validation methods
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  String? validateEmail(String email) {
    if (email.trim().isEmpty) {
      return 'Email is required';
    }
    if (!_isValidEmail(email)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.trim().isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  bool validateForm(String email, String password) {
    String? emailError = validateEmail(email);
    String? passwordError = validatePassword(password);
    
    if (emailError != null || passwordError != null) {
      _errorMessage = emailError ?? passwordError;
      notifyListeners();
      return false;
    }
    
    _errorMessage = null;
    notifyListeners();
    return true;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    // Validate form before proceeding
    if (!validateForm(email, password)) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      
      // Clear any previous errors on successful login
      _errorMessage = null;
      notifyListeners();
      
      Navigator.pushReplacementNamed(context, RoutesName.main);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          _errorMessage = 'No account found with this email address.';
          break;
        case 'wrong-password':
          _errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          _errorMessage = 'Invalid email address.';
          break;
        case 'user-disabled':
          _errorMessage = 'This account has been disabled.';
          break;
        case 'too-many-requests':
          _errorMessage = 'Too many failed attempts. Please try again later.';
          break;
        case 'network-request-failed':
          _errorMessage = 'Network error. Please check your connection.';
          break;
        default:
          _errorMessage = 'Login failed: ${e.message}';
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
