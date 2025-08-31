import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTruckEntryCardWidget extends StatelessWidget {
  final String truckNumber;
  final String status;
  final String timeIn;
  final String driverName;
  final String driverRole;
  final VoidCallback onTimeOutPressed;
  final VoidCallback onViewLogsPressed;

  const CustomTruckEntryCardWidget({
    super.key,
    required this.truckNumber,
    required this.status,
    required this.timeIn,
    required this.driverName,
    required this.driverRole,
    required this.onTimeOutPressed,
    required this.onViewLogsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColor.filledColor,
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          // Truck Info Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/truck.svg"),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Truck No",
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textScaleFactor * 12,
                        ),
                      ),
                      Text(
                        truckNumber,
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.normal,
                          fontSize: Responsive.textScaleFactor * 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(status),
            ],
          ),

          SizedBox(height: Responsive.h(1)),
          const Divider(),
          SizedBox(height: Responsive.h(1)),

          // Time-In
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Time-In",
                    style: GoogleFonts.rethinkSans(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.textScaleFactor * 12,
                    ),
                  ),
                  Text(
                    timeIn,
                    style: GoogleFonts.rethinkSans(
                      fontWeight: FontWeight.normal,
                      fontSize: Responsive.textScaleFactor * 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: Responsive.h(1)),

          // Driver Info + View Logs Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.primaryColor.withOpacity(
                      0.8,
                    ), // optional background
                    child: Text(
                      Utils().getInitials(driverName),
                      style: GoogleFonts.rethinkSans(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driverName,
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textScaleFactor * 12,
                        ),
                      ),
                      Text(
                        driverRole,
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.normal,
                          fontSize: Responsive.textScaleFactor * 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: onViewLogsPressed,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Text(
                    "View All Logs",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: Responsive.h(1)),

          // Time-Out Button
          GestureDetector(
            onTap: onTimeOutPressed,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(22),
              ),
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  "Press to Time Out",
                  style: GoogleFonts.rethinkSans(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
