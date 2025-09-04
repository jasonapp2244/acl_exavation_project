import 'package:acl/viewmodel/logout_view_model.dart';
import 'package:acl/viewmodel/signup_view_model.dart';
import 'package:acl/viewmodel/user_profile_model_view.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileModelView>(
        context,
        listen: false,
      ).fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final logoutVM = Provider.of<LogoutViewModel>(context);
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildBody(logoutVM)),
          ],
        ),
      ),
    );
  }

  /// ------------------- Header -------------------
  Widget _buildHeader() {
    return Container(
      height: Responsive.h(10),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment.topRight,
          radius: 1.2,
          focalRadius: 0.1,
          colors: [Color(0xFF4EEED0), Color(0xFF111B19)],
        ),
      ),
      child: Padding(
        padding: Responsive.padding(left: 4, right: 4, top: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Settings",
              style: GoogleFonts.rethinkSans(
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.textScaleFactor * 26,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ------------------- Body -------------------
  Widget _buildBody(LogoutViewModel logoutVM) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<UserProfileModelView>(
          builder: (context, profileController, child) {
            return Column(
              children: [
                _buildProfileAvatar(profileController),
                _buildProfileInfo(profileController),
                SizedBox(height: Responsive.h(2)),
                _buildSettingsOptions(),
                SizedBox(height: Responsive.h(1)),
                _buildLogoutButton(logoutVM),
                SizedBox(height: Responsive.h(1)),
                _buildAppVersion(),
              ],
            );
          },
        ),
      ),
    );
  }

  /// ------------------- Profile Avatar -------------------
  Widget _buildProfileAvatar(UserProfileModelView controller) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RoutesName.editProfile),
      child: Container(
        width: 110,
        height: 109,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.07), width: 1),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  controller.getInitials(controller.name.toString()),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primaryColor,
                ),
                child: const Icon(Icons.edit, size: 14, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ------------------- Profile Info -------------------
  Widget _buildProfileInfo(UserProfileModelView controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            controller.name.isNotEmpty ? controller.name : "Loading...",
            style: GoogleFonts.rethinkSans(
              fontSize: Responsive.textScaleFactor * 20,
              fontWeight: FontWeight.bold,
              color: AppColor.textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            controller.email.isNotEmpty ? controller.email : "Loading...",
            style: GoogleFonts.rethinkSans(
              fontSize: Responsive.textScaleFactor * 14,
              fontWeight: FontWeight.normal,
              color: AppColor.filletextdColor,
            ),
          ),
        ],
      ),
    );
  }

  /// ------------------- Settings Options -------------------
  Widget _buildSettingsOptions() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.filledColor,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildSettingOption(
              iconPath: "assets/icons/chnage_password.svg",
              title: "Change Password",
              onTap: () =>
                  Navigator.pushNamed(context, RoutesName.changePassword),
            ),
            const Divider(),
            _buildSettingOption(
              iconPath: "assets/icons/email.svg",
              title: "Change Email Address",
              onTap: () => Navigator.pushNamed(context, RoutesName.changeEmail),
            ),
          ],
        ),
      ),
    );
  }

  /// ------------------- Individual Setting Option -------------------
  Widget _buildSettingOption({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(iconPath),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.rethinkSans(
                    fontSize: Responsive.textScaleFactor * 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SvgPicture.asset("assets/icons/Polygon 1.svg"),
          ],
        ),
      ),
    );
  }

  /// ------------------- Logout Button -------------------
  Widget _buildLogoutButton(LogoutViewModel logoutVM) {
    return GestureDetector(
      onTap: () async {
        await logoutVM.logoutUser();
        Navigator.pushReplacementNamed(context, RoutesName.splash);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: AppColor.redColor,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Center(
            child: Text(
              "Logout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// ------------------- App Version -------------------
  Widget _buildAppVersion() {
    return Text(
      "v1.0.0",
      style: GoogleFonts.rethinkSans(fontSize: Responsive.textScaleFactor * 8),
    );
  }
}
