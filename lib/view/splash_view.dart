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

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 🎬 Setup fade-in controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Start fade-in
    _controller.forward();

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3)); // allow fade to play

    final uid = await _storage.read(key: 'uid');
    final user = FirebaseAuth.instance.currentUser;

    if (uid != null && uid.isNotEmpty && user != null) {
      Navigator.pushReplacementNamed(context, RoutesName.main);
    } else {
      Navigator.pushReplacementNamed(context, RoutesName.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SvgPicture.asset("assets/images/Isolation_Mode.svg"),
          ),
        ),
      ),
    );
  }
}
