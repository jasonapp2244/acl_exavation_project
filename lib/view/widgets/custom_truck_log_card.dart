import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/utils.dart';
import 'package:acl/view/widgets/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_line/dotted_line.dart';

class CustomTruckEntryCard extends StatelessWidget {
  final String id;
  final String driverName;
  final String role;
  final String truckNumber;
  final int totalLogs;
  final String timeIn;
  final String timeOut;
  final String? status;

  final VoidCallback? onEdit;
  final VoidCallback? onViewLogs;
  final VoidCallback? onDelete;

  const CustomTruckEntryCard({
    super.key,
    required this.id,
    required this.driverName,
    required this.role,
    required this.truckNumber,
    required this.totalLogs,
    required this.timeIn,
    required this.timeOut,
    this.status,
    this.onEdit,
    this.onViewLogs,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: AppColor.filledColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(1),
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔵 Status
              Row(
                children: [
                  CustomStatusTile(
                    title: status ?? 'On Site',
                    isOnline: status == 'On Site' ? true : false,
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(2)),

              // 🔵 Driver Info + Truck Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/Ellipse 2@2x.png",
                    ),
                  ),
                  SizedBox(width: Responsive.w(1)),
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
                        role,
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.normal,
                          fontSize: Responsive.textScaleFactor * 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: Responsive.w(2)),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/truck.svg"),
                      SizedBox(width: Responsive.w(2)),
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
                      SizedBox(width: Responsive.w(4)),
                      Container(
                        height: 20,
                        width: 1,
                        color: AppColor.filletextdColor,
                      ),
                      SizedBox(width: Responsive.w(2)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Logs",
                            style: GoogleFonts.rethinkSans(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.textScaleFactor * 12,
                            ),
                          ),
                          Text(
                            "$totalLogs trips recorded",
                            style: GoogleFonts.rethinkSans(
                              fontWeight: FontWeight.normal,
                              fontSize: Responsive.textScaleFactor * 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: Responsive.h(1)),
              Divider(),
              SizedBox(height: Responsive.h(1)),

              // 🔵 Time In → Time Out timeline
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time-In",
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textScaleFactor * 10,
                        ),
                      ),
                      Text(
                        formatTime(timeIn),
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.normal,
                          fontSize: Responsive.textScaleFactor * 8,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: Responsive.w(1)),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColor.textColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: DottedLine(
                      dashLength: 4,
                      dashGapLength: 4,
                      lineThickness: 1,
                      dashColor: AppColor.textColor,
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColor.textColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: Responsive.w(1)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time-Out",
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textScaleFactor * 10,
                        ),
                      ),
                      Text(
                        formatTime(timeOut),
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.normal,
                          fontSize: Responsive.textScaleFactor * 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: Responsive.h(1)),

              // 🔵 Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 10.0,
                        ),
                        child: Text(
                          "Edit",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rethinkSans(
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.textScaleFactor * 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.w(1)),
                  Expanded(
                    child: GestureDetector(
                      onTap: onViewLogs,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          "View All Logs",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rethinkSans(
                            color: AppColor.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.w(1)),
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.redColor.withOpacity(0.24),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("assets/icons/delete-03.svg"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
