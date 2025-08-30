import 'package:acl/controller/logout_view_model.dart';
import 'package:acl/controller/signup_view_model.dart';
import 'package:acl/controller/user_profile_controller.dart';
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
    // Fetch user profile data when view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileController>(
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
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Container(
                height: Responsive.h(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
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
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.whiteColor.withValues(alpha: 0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            "assets/icons/notificsation.svg",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Consumer<UserProfileController>(
                      builder: (context, profileController, child) {
                        return Column(
                          spacing: 5,
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                RoutesName.editProfile,
                              ),
                              child: Container(
                                width: 110,
                                height: 109,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.07),
                                    width: 1,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Main content area
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Center(
                                        child: Text(
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 40,
                                          ),
                                          profileController.getInitials(
                                            profileController.name.toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Edit icon in bottom right corner
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
                                        child: Icon(
                                          Icons.edit,
                                          size: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Profile Section with Edit Icon
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),

                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              profileController.name.isNotEmpty
                                                  ? profileController.name
                                                  : "Loading...",
                                              style: GoogleFonts.rethinkSans(
                                                fontSize:
                                                    Responsive.textScaleFactor *
                                                    20,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.textdColor,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              profileController.email.isNotEmpty
                                                  ? profileController.email
                                                  : "Loading...",
                                              style: GoogleFonts.rethinkSans(
                                                fontSize:
                                                    Responsive.textScaleFactor *
                                                    14,
                                                fontWeight: FontWeight.normal,
                                                color: AppColor.filletextdColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: Responsive.h(2)),

                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor.filledColor,
                                borderRadius: BorderRadiusDirectional.circular(
                                  26,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        RoutesName.changePassword,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/chnage_password.svg",
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                "Change Password",
                                                style: GoogleFonts.rethinkSans(
                                                  fontSize:
                                                      Responsive
                                                          .textScaleFactor *
                                                      16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SvgPicture.asset(
                                            "assets/icons/Polygon 1.svg",
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(children: [Expanded(child: Divider())]),

                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        RoutesName.changeEmail,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/email.svg",
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                "Change Email Address",
                                                style: GoogleFonts.rethinkSans(
                                                  fontSize:
                                                      Responsive
                                                          .textScaleFactor *
                                                      16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SvgPicture.asset(
                                            "assets/icons/Polygon 1.svg",
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Row(children: [Expanded(child: Divider())]),
                                    // GestureDetector(
                                    //   onTap: () => Navigator.pushNamed(
                                    //     context,
                                    //     RoutesName.notifications,
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Row(
                                    //         children: [
                                    //           SvgPicture.asset(
                                    //             "assets/icons/notification.svg",
                                    //           ),
                                    //           SizedBox(width: 12),
                                    //           Text(
                                    //             "Notifications",
                                    //             style: GoogleFonts.rethinkSans(
                                    //               fontSize:
                                    //                   Responsive
                                    //                       .textScaleFactor *
                                    //                   16,
                                    //               fontWeight: FontWeight.w500,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       SvgPicture.asset(
                                    //         "assets/icons/Polygon 1.svg",
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // Row(children: [Expanded(child: Divider())]),
                                    // GestureDetector(
                                    //   onTap: () => Navigator.pushNamed(
                                    //     context,
                                    //     RoutesName.timeFormat,
                                    //   ),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Row(
                                    //         children: [
                                    //           SvgPicture.asset(
                                    //             "assets/icons/Frame 1000002074 (1).svg",
                                    //           ),
                                    //           SizedBox(width: 12),
                                    //           Text(
                                    //             "Time Format",
                                    //             style: GoogleFonts.rethinkSans(
                                    //               fontSize:
                                    //                   Responsive
                                    //                       .textScaleFactor *
                                    //                   16,
                                    //               fontWeight: FontWeight.w500,
                                    //             ),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //       SvgPicture.asset(
                                    //         "assets/icons/Polygon 1.svg",
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.h(1)),

                            GestureDetector(
                              onTap: () async {
                                await logoutVM.logoutUser();
                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutesName.splash,
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(26),
                                  color: AppColor.redColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Logout",
                                      style: GoogleFonts.rethinkSans(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.h(1)),
                            Text(
                              "v1.0.0",
                              style: GoogleFonts.rethinkSans(
                                fontSize: Responsive.textScaleFactor * 8,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
