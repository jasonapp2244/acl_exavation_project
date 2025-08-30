import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/view/homeview.dart';
import 'package:acl/view/manage_trucks.dart';
import 'package:acl/view/setting_view.dart';
import 'package:acl/view/truck_log_view.dart';
import 'package:acl/view/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const Homeview(),
    const TruckLogView(),
    const ManageTrucks(),
    const SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabChanged: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
