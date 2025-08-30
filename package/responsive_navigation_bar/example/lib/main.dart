import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

///
class MyApp extends StatefulWidget {
  ///
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // extendBody: true,
        bottomNavigationBar: ResponsiveNavigationBar(
          selectedIndex: _selectedIndex,
          onTabChange: changeTab,
          // showActiveButtonText: false,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          navigationBarButtons: const <NavigationBarButton>[
            NavigationBarButton(
              text: 'Dashboard',
              imagePath: 'assets/icons/dashboard.svg',
              backgroundGradient: LinearGradient(
                colors: [Color(0xff4EEED0), Colors.white],
              ),
            ),

            NavigationBarButton(
              text: 'Truck Logs',
              imagePath: 'assets/icons/truck_logs.svg',
              backgroundGradient: LinearGradient(
                colors: [Colors.white, Colors.white],
              ),
            ),
            NavigationBarButton(
              text: 'Trucks',
              imagePath: 'assets/icons/truck_icon.svg',
              backgroundGradient: LinearGradient(
                colors: [Colors.white, Colors.white],
              ),
            ),
            NavigationBarButton(
              text: 'Settings',
              imagePath: 'assets/icons/truck_icon.svg',
              backgroundGradient: LinearGradient(
                colors: [Colors.white, Colors.white],
              ),
            )
            // NavigationBarButton(
            //   text: 'Home',
            //   imagePath: 'assets/icons/home.svg',
            //   backgroundGradient: LinearGradient(
            //     colors: [Colors.white, Colors.white],
            //   ),
            // ),
            // NavigationBarButton(
            //   text: 'Logs',
            //   imagePath: 'assets/icons/courses.svg',
            //   backgroundGradient: LinearGradient(
            //     colors: [Colors.white, Colors.white],
            //   ),
            // ),
            // NavigationBarButton(
            //   text: 'Trucks',
            //   imagePath: 'assets/icons/quizzes.svg',
            //   backgroundGradient: LinearGradient(
            //     colors: [Colors.white, Colors.white],
            //   ),
            // ),
            // NavigationBarButton(
            //   text: 'Settings',
            //   imagePath: 'assets/icons/profile.svg',
            //   backgroundGradient: LinearGradient(
            //     colors: [Colors.white, Colors.white],
            //   ),
            // ),
            // NavigationBarButton(
            //   text: 'Tab 3',
            //   imagePath: 'assets/icons/courses.svg',
            //   backgroundGradient: LinearGradient(
            //     colors: [Colors.green, Colors.yellow],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
