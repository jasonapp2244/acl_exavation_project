import 'package:acl/data/response/status.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/utils.dart';
import 'package:acl/view/widgets/custom_title.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomTruckEntryCardWidget extends StatelessWidget {
  final String truckNumber;
  final String status;
  final DateTime timeIn;
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
              CustomStatusTile(
                title: status ?? 'On Site',
                isOnline: status == 'On Site' ? true : false,
              ),
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
                    formatTime(timeIn) ??
                        DateFormat.jm().format(DateTime.now()),
                    style: GoogleFonts.rethinkSans(
                      fontWeight: FontWeight.normal,
                      fontSize: Responsive.textScaleFactor * 10,
                    ),
                  ),
                ],
              ),
              SizedBox(width: Responsive.h(2)),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColor.textdColor,
                  shape: BoxShape.circle,
                ),
              ),

              SizedBox(
                width: 100, // or any value
                child: DottedLine(
                  dashLength: 4,
                  //       dashGapLength: 4,
                  lineThickness: 1,
                  dashColor: AppColor.textdColor,
                ),
              ),

              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColor.textdColor,
                  shape: BoxShape.circle,
                ),
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
          SwipeButtonDemo(),

          // Time-Out Button
          //   GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => MyApp()),
          //       );
          //     },
          //     child: Container(
          //       width: double.infinity,
          //       decoration: BoxDecoration(
          //         color: AppColor.primaryColor,
          //         borderRadius: BorderRadius.circular(22),
          //       ),
          //       padding: const EdgeInsets.all(8),
          //       child: Center(
          //         child: Text(
          //           "Press to Time Out",
          //           style: GoogleFonts.rethinkSans(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }
}

class SwipeButtonDemo extends StatefulWidget {
  const SwipeButtonDemo({super.key});

  @override
  State<SwipeButtonDemo> createState() => _SwipeButtonDemoState();
}

class _SwipeButtonDemoState extends State<SwipeButtonDemo> {
  double _dragValue = 0.0;
  bool _completed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(35)),
        child: Stack(
          children: [
            // Background
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _dragValue * 320,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.white, Colors.white],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(35),
              ),
            ),

            // Swipe thumb
            Positioned(
              top: 5,
              bottom: 5,
              right: _dragValue * 270,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (!_completed) {
                    setState(() {
                      _dragValue = (_dragValue - details.delta.dx / 320).clamp(
                        0.0,
                        1.0,
                      );

                      if (_dragValue >= 0.95) {
                        _completed = true;
                        Future.delayed(const Duration(milliseconds: 500), () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Timed out successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        });
                      }
                    });
                  }
                },
                onHorizontalDragEnd: (_) {
                  if (!_completed && _dragValue < 0.7) {
                    setState(() {
                      _dragValue = 0.0;
                    });
                  }
                },
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0x3D4EEED0),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back, // points left
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),

            // Text
            Positioned.fill(
              child: Center(
                child: Text(
                  'Swipe to Time Out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
