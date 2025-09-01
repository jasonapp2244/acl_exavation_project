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

import 'package:acl/viewmodel/change_email_model_view.dart';
import 'package:acl/viewmodel/forgot_password_view_model.dart';
import 'package:acl/viewmodel/login_view_model.dart';
import 'package:acl/viewmodel/logout_view_model.dart';
import 'package:acl/viewmodel/searchfield_providerl_view_model.dart';
import 'package:acl/viewmodel/settings_reset_password_view_model.dart';
import 'package:acl/viewmodel/signup_view_model.dart';
import 'package:acl/viewmodel/truck_driver_model_view.dart';
import 'package:acl/viewmodel/truck_log_detail_model_view.dart';
import 'package:acl/viewmodel/user_profile_model_view.dart';
import 'package:acl/utils/routes/routes.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/firebase_options.dart';
import 'package:acl/view/add_truck_entery_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignupViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => LogoutViewModel()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordViewModel()),
        ChangeNotifierProvider(create: (_) => ChangePasswordModel()),
        ChangeNotifierProvider(create: (_) => ChangeEmailModelView()),
        ChangeNotifierProvider(create: (_) => UserProfileController()),
        ChangeNotifierProvider(
          create: (_) => TruckEntryProvider(),
          child: AddTruckEnteryView(),
        ),
        ChangeNotifierProvider(create: (_) => SearchTruckProvider()),
        ChangeNotifierProvider(create: (_) => TruckLogDetailController()),
        ChangeNotifierProvider(create: (_) => TruckEntryProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
