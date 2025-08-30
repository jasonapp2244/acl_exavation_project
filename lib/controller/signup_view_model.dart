import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignupViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Validation methods
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPassword(String password) {
    // At least 6 characters, can include letters, numbers, and special characters
    return password.length >= 6;
  }

  bool _isValidName(String name) {
    // Name should be at least 2 characters and contain only letters, spaces, and common name characters
    return name.trim().length >= 2 && RegExp(r'^[a-zA-Z\s\-\.]+$').hasMatch(name.trim());
  }

  String? validateName(String name) {
    if (name.trim().isEmpty) {
      return 'Full name is required';
    }
    if (name.trim().length < 2) {
      return 'Name must be at least 2 characters long';
    }
    if (!_isValidName(name)) {
      return 'Name can only contain letters, spaces, hyphens, and periods';
    }
    return null;
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
    if (!_isValidPassword(password)) {
      return 'Password is too weak';
    }
    return null;
  }

  bool validateForm(String userName, String email, String password) {
    String? nameError = validateName(userName);
    String? emailError = validateEmail(email);
    String? passwordError = validatePassword(password);
    
    if (nameError != null || emailError != null || passwordError != null) {
      _errorMessage = nameError ?? emailError ?? passwordError;
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

  Future<void> signup(String userName, String email, String password) async {
    // Validate form before proceeding
    if (!validateForm(userName, email, password)) {
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      print('Starting signup process for email: $email');

      // Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(), 
            password: password
          );

      print('User created successfully with UID: ${userCredential.user?.uid}');

      // Update display name in Auth profile
      await userCredential.user?.updateDisplayName(userName.trim());
      print('Display name updated successfully');

      // Save user details in Firestore (document ID = UID)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
            'name': userName.trim(),
            'email': email.trim(),
            'createdAt': DateTime.now(),
            'uid': userCredential.user!.uid,
          });

      print('User data saved to Firestore successfully');
      
      // Clear any previous errors on successful signup
      _errorMessage = null;
      notifyListeners();
      
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.code} - ${e.message}');
      switch (e.code) {
        case 'weak-password':
          _errorMessage = 'The password provided is too weak. Please choose a stronger password.';
          break;
        case 'email-already-in-use':
          _errorMessage = 'An account already exists with this email address.';
          break;
        case 'invalid-email':
          _errorMessage = 'Invalid email address.';
          break;
        case 'operation-not-allowed':
          _errorMessage = 'Email/password accounts are not enabled. Please contact support.';
          break;
        case 'network-request-failed':
          _errorMessage = 'Network error. Please check your connection.';
          break;
        default:
          _errorMessage = 'Authentication error: ${e.message}';
      }
    } on FirebaseException catch (e) {
      print('FirebaseException: ${e.code} - ${e.message}');
      _errorMessage = 'Database error: ${e.message}';
    } catch (e) {
      print('Unexpected error during signup: $e');
      _errorMessage = 'An unexpected error occurred. Please try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
