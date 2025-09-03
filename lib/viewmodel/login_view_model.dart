import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/utils/routes/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginModelViewModel extends ChangeNotifier {
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
    notifyListeners();

    try {
  var userCredential =   await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
 User? user = userCredential.user;

  if (user != null) {
    print("Signed in as: ${user.uid}");
    // Optionally save user locally
     await Utils().saveUser(user);
  }
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
        case 'invalid-credential':
        case 'invalid-credentials':
          _errorMessage =
              'Invalid email or password. Please check your credentials.';
          break;
        case 'operation-not-allowed':
          _errorMessage = 'Email/password sign in is not enabled.';
          break;

        default:
          // Check if the error message contains specific keywords
          if (e.message?.toLowerCase().contains('credential') == true ||
              e.message?.toLowerCase().contains('incorrect') == true ||
              e.message?.toLowerCase().contains('malformed') == true ||
              e.message?.toLowerCase().contains('expired') == true) {
            _errorMessage =
                'Invalid email or password. Please check your credentials.';
          } else {
            _errorMessage = 'Login failed: ${e.message}';
          }
      }
    } catch (e) {
      // Check if it's a general credential error
      if (e.toString().toLowerCase().contains('credential') ||
          e.toString().toLowerCase().contains('incorrect') ||
          e.toString().toLowerCase().contains('malformed') ||
          e.toString().toLowerCase().contains('expired')) {
        _errorMessage =
            'Invalid email or password. Please check your credentials.';
      } else {
        _errorMessage = 'An unexpected error occurred. Please try again.';
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
