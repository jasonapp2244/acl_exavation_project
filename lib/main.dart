
// import 'package:acl/utils/routes/routes.dart';
// import 'package:acl/utils/routes/routes_name.dart';
// import 'package:acl/view/add_truck_entery_view.dart';
// import 'package:acl/view/bottom_nav_bar.dart';
// import 'package:acl/view/change_email_view.dart';
// import 'package:acl/view/change_password_view.dart';
// import 'package:acl/view/homeview.dart';
// import 'package:acl/view/loginview.dart';
// import 'package:acl/view/manage_trucks.dart';
// import 'package:acl/view/notifications_view.dart';
// import 'package:acl/view/setting_view.dart';
// import 'package:acl/view/splash_view.dart';
// import 'package:acl/view/time_format_view.dart';
// import 'package:acl/view/truck_log_detail_view.dart';
// import 'package:acl/view/truck_log_view.dart';
// import 'package:acl/viewmodel/auth_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(MultiProvider(
//     providers: [ChangeNotifierProvider(create: (_) => AuthViewmodel())],
//     child: MyApp(),
//   ));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // initialRoute: RoutesName.login,
//       // onGenerateRoute: Routes.generateRoutes,
//       home: BottomNavBar(),
//     );
//   }
// }



import 'package:acl/utils/routes/routes.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/view/homeview.dart';
import 'package:acl/view/loginview.dart';
import 'package:acl/view/main_wrapper.dart';
import 'package:acl/view/splash_view.dart';
import 'package:acl/viewmodel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AuthViewmodel())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoutes,
      // home: BottomNavBar (),
    );
  }
}