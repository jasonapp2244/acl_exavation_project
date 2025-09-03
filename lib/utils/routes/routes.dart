import 'package:acl/viewmodel/edit_truck_entry_model_view.dart';
import 'package:acl/viewmodel/truck_log_detail_model_view.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/view/add_truck_entery_view.dart';
import 'package:acl/view/change_email_view.dart';
import 'package:acl/view/change_password_view.dart';
import 'package:acl/view/edit_profile_view.dart';
import 'package:acl/view/homeview.dart';
import 'package:acl/view/loginview.dart';
import 'package:acl/view/main_wrapper.dart';
import 'package:acl/view/manage_trucks.dart';
import 'package:acl/view/notifications_view.dart';
import 'package:acl/view/search_field_view.dart';
import 'package:acl/view/setting_view.dart';
import 'package:acl/view/sginupview.dart';
import 'package:acl/view/splash_view.dart';
import 'package:acl/view/time_format_view.dart';
import 'package:acl/view/truck_log_detail_view.dart';
import 'package:acl/view/truck_log_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case RoutesName.login:
        return MaterialPageRoute(builder: (_) => Loginview());
      case RoutesName.signup:
        return MaterialPageRoute(builder: (_) => SignupView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) => Homeview());
      case RoutesName.truckLog:
        return MaterialPageRoute(builder: (_) => TruckLogView());

      case RoutesName.main:
        return MaterialPageRoute(builder: (_) => MainScreen());
      case RoutesName.truckLogDetail:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => TruckLogDetailViewModel(),
            child: TruckLogDetailView(),
          ),
        );
      case RoutesName.manageTrucks:
        return MaterialPageRoute(builder: (_) => ManageTrucks());
      case RoutesName.addTruckEntry:
        print('Navigating to AddTruckEnteryView');
        return MaterialPageRoute(builder: (_) => const AddTruckEnteryView());
      case RoutesName.settings:
        return MaterialPageRoute(builder: (_) => SettingView());
      case RoutesName.notifications:
        return MaterialPageRoute(builder: (_) => NotificationsView());
      case RoutesName.changePassword:
        return MaterialPageRoute(builder: (_) => ChangePasswordView());
      case RoutesName.changeEmail:
        return MaterialPageRoute(builder: (_) => ChangeEmailView());
      case RoutesName.editProfile:
        return MaterialPageRoute(builder: (_) => EditProfileView());
      case RoutesName.eidtTruckEntry:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (context) => EditTruckEntryModelView(),
            child: EditProfileView(),
          ),
        );
      case RoutesName.timeFormat:
        return MaterialPageRoute(builder: (_) => TimeFormatView());
      case RoutesName.search:
        return MaterialPageRoute(builder: (_) => SearchFieldView());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
