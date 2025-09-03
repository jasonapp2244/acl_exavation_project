import 'dart:async';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(milliseconds: 500));

    Timer(const Duration(seconds: 2), () async {
      // ✅ Option 1: Use secure storage
      final uid = await _storage.read(key: 'uid');

      // ✅ Option 2: Use FirebaseAuth directly (safer)
      final user = FirebaseAuth.instance.currentUser;

      if (uid != null && uid.isNotEmpty && user != null) {
        // Already logged in → go to Home
        Navigator.pushReplacementNamed(context, RoutesName.main);
      } else {
        // Not logged in → go to Login
        Navigator.pushReplacementNamed(context, RoutesName.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.2,
            colors: [Color(0xFF4EEED0), Color(0xFF111B19)],
          ),
        ),
        child: Center(
          child: SvgPicture.asset("assets/images/Isolation_Mode.svg"),
        ),
      ),
    );
  }
}
