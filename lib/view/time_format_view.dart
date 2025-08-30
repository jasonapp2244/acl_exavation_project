import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeFormatView extends StatefulWidget {
  const TimeFormatView({super.key});

  @override
  State<TimeFormatView> createState() => _TimeFormatViewState();
}

class _TimeFormatViewState extends State<TimeFormatView> {
  int _timeFormat = 1; // 1 for 12-hour, 2 for 24-hour format

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: Text(
          "Time Format",
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
                    // 12-hour format option
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "12-hour format",
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textScaleFactor * 16,
                        ),
                      ),
                      trailing: Radio<int>(
                        value: 1,
                        groupValue: _timeFormat,
                        onChanged: (int? value) {
                          setState(() {
                            _timeFormat = value!;
                          });
                        },
                        activeColor: AppColor.primaryColor,
                      ),
                    ),
                    const Divider(),

                    // 24-hour format option
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "24-hour format",
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textScaleFactor * 16,
                        ),
                      ),
                      trailing: Radio<int>(
                        value: 2,
                        groupValue: _timeFormat,
                        onChanged: (int? value) {
                          setState(() {
                            _timeFormat = value!;
                          });
                        },
                        activeColor: AppColor.primaryColor,
                      ),
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