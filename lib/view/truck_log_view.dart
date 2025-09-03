import 'package:acl/model/truck_driver_record_model.dart';
import 'package:acl/model/truck_log_detail_model.dart';
import 'package:acl/model/truck_log_record_model.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/view/widgets/custom_title.dart';
import 'package:acl/view/widgets/custom_truck_log_card.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TruckLogView extends StatelessWidget {
  const TruckLogView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: Responsive.h(20),
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
                padding: Responsive.padding(
                  left: 4,
                  right: 4,
                  top: 2,
                  bottom: 0,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Truck Logs",
                          style: GoogleFonts.rethinkSans(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.textScaleFactor * 26,
                          ),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     shape: BoxShape.circle,
                        //     color: AppColor.whiteColor.withValues(alpha: 0.2),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(12.0),
                        //     child: SvgPicture.asset(
                        //       "assets/icons/notificsation.svg",
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: Responsive.h(1)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/search.svg",
                                  ),
                                ),
                                hintText: "Search Truck by Number",
                                hintStyle: GoogleFonts.rethinkSans(
                                  color: AppColor.filletextdColor,
                                ),
                                filled: true,
                                fillColor: AppColor.whiteColor.withValues(
                                  alpha: 0.2,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.whiteColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.whiteColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.whiteColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.whiteColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Responsive.w(1)),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                            context,
                            RoutesName.addTruckEntry,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: SvgPicture.asset(
                                "assets/icons/Frame 8.svg",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Showing logs from",
                            style: GoogleFonts.rethinkSans(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.textScaleFactor * 16,
                            ),
                          ),
                        ],
                      ),

                      Expanded(
                        child: StreamBuilder<List<TruckDriverRecordModel>>(
                          stream: TruckLogDetailModelController()
                              .truckEntriesStream(
                                date:
                                    DateTime.now(), // optional, pass specific date if needed
                              ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(child: Text("No logs found"));
                            }

                            final logs = snapshot.data!;

                            return ListView.builder(
                              itemCount: logs.length,
                              itemBuilder: (context, index) {
                                final log = logs[index];
                                return CustomTruckEntryCard(
                                  driverName: log.driverName,
                                  role: 'Driver',
                                  truckNumber: log.truckNumber,
                                  totalLogs: logs.length,
                                  timeIn: log.timeIn.toString(),
                                  timeOut: log.timeOut.toString(),
                                  onDelete: () {
                                    // Handle delete
                                  },
                                  onEdit: () {
                                    // Handle edit
                                  },
                                  onViewLogs: () {
                                    // Handle view logs
                                  },
                                );
                              },
                            );
                          },
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
    );
  }
}
