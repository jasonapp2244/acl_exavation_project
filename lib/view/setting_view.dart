import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  ), // Apply the gradient here
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
                    child: Column(
                      spacing: 5,
                      children: [
                        SvgPicture.asset("assets/icons/Frame 1171275574.svg"),
                        Text(
                          "Michel Smith",
                          style: GoogleFonts.rethinkSans(
                            fontSize: Responsive.textScaleFactor * 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Michel768@gmail.com",
                          style: GoogleFonts.rethinkSans(
                            fontWeight: FontWeight.normal,
                          ),
                        ),

                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.filledColor,
                            borderRadius: BorderRadiusDirectional.circular(26),
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
                                          Text("Change Password"),
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
                                          Text("Change Email Address"),
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
                                    RoutesName.notifications,
                                  ),

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/notification.svg",
                                          ),
                                          Text("Notifications"),
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
                                    RoutesName.timeFormat,
                                  ),

                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/Frame 1000002074 (1).svg",
                                          ),
                                          Text("Time Format"),
                                        ],
                                      ),
                                      SvgPicture.asset(
                                        "assets/icons/Polygon 1.svg",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.h(1)),

                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                            context,
                            RoutesName.splash,
                          ),
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
