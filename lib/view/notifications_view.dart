import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  bool _pushNotifications = false;
  bool _timeInOutAlerts = true;
  bool _emailNotifications = false;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: GoogleFonts.rethinkSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColor.filledColor,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Push Notifications Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Push Notifications",
                          style: GoogleFonts.rethinkSans(
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.textScaleFactor * 16,
                          ),
                        ),
                        Switch(
                          value: _pushNotifications,
                          onChanged: (value) {
                            setState(() {
                              _pushNotifications = value;
                            });
                          },
                          activeTrackColor: AppColor.primaryColor,
                          activeColor: AppColor.filledColor,
                        ),
                      ],
                    ),
                    const Divider(),

                    // Time-In/Out Alerts Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Time-In/Out Alerts",
                          style: GoogleFonts.rethinkSans(
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.textScaleFactor * 16,
                          ),
                        ),
                        Switch(
                          value: _timeInOutAlerts,
                          onChanged: (value) {
                            setState(() {
                              _timeInOutAlerts = value;
                            });
                          },
                          activeTrackColor: AppColor.primaryColor,
                          activeColor: AppColor.filledColor,
                        ),
                      ],
                    ),
                    const Divider(),

                    // Email Notifications Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Email Notifications",
                          style: GoogleFonts.rethinkSans(
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.textScaleFactor * 16,
                          ),
                        ),
                        Switch(
                          value: _emailNotifications,
                          onChanged: (value) {
                            setState(() {
                              _emailNotifications = value;
                            });
                          },
                          activeTrackColor: AppColor.primaryColor,
                          activeColor: AppColor.filledColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
