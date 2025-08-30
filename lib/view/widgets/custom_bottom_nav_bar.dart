import 'package:acl/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ResponsiveNavigationBar(
        backgroundColor: Colors.black,

        activeIconColor: const Color(0xff111B19),
        showActiveButtonText: true,

        selectedIndex: widget.currentIndex,
        onTabChange: widget.onTabChanged,
        textStyle: TextStyle(
          color: Color(0xff111B19),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        navigationBarButtons: const <NavigationBarButton>[
          NavigationBarButton(
            text: 'Dashboard',
            imagePath: 'assets/icons/dashboard.svg',
            backgroundGradient: LinearGradient(
              colors: [Color(0xff4EEED0), Color(0xff4EEED0)],
            ),
          ),

          NavigationBarButton(
            text: 'Truck Logs',
            imagePath: 'assets/icons/truck_logs.svg',
            backgroundGradient: LinearGradient(
              colors: [Color(0xff4EEED0), Color(0xff4EEED0)],
            ),
          ),

          NavigationBarButton(
            text: 'Trucks',
            imagePath: 'assets/icons/truck_icon.svg',
            backgroundGradient: LinearGradient(
              colors: [Color(0xff4EEED0), Color(0xff4EEED0)],
            ),
          ),
          NavigationBarButton(
            text: 'Settings',
            imagePath: 'assets/icons/settings.svg',
            backgroundGradient: LinearGradient(
              colors: [Color(0xff4EEED0), Color(0xff4EEED0)],
            ),
          ),
        ],
      ),
    );
  }
}
