import 'package:acl/viewmodel/edit_truck_entry_model_view.dart';
import 'package:acl/viewmodel/truck_log_detail_model_view.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/view/edit_truck_entry_view.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TruckLogDetailView extends StatefulWidget {
  final String? truckNumber;

  const TruckLogDetailView({super.key, this.truckNumber});

  @override
  State<TruckLogDetailView> createState() => _TruckLogDetailViewState();
}

class _TruckLogDetailViewState extends State<TruckLogDetailView> {
  @override
  void initState() {
    super.initState();
    // Load data when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.truckNumber != null) {
        context.read<TruckLogDetailController>().loadTruckLogs(
          widget.truckNumber!,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: Text("Truck ${widget.truckNumber}"),
      ),
      body: SafeArea(
        child: Padding(
          padding: Responsive.padding(left: 4, right: 4, top: 2, bottom: 4),
          child: Consumer<TruckLogDetailController>(
            builder: (context, controller, child) {
              return Column(
                children: [
                  // Header Info Container
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: AppColor.filledColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/Ellipse 2@2x.png",
                                width: 37,
                                height: 37,
                              ),
                              SizedBox(width: Responsive.w(1)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Driver Name",
                                    style: GoogleFonts.rethinkSans(
                                      fontWeight: FontWeight.normal,
                                      fontSize: Responsive.textScaleFactor * 12,
                                    ),
                                  ),
                                  Text(
                                    controller.driverName,
                                    style: GoogleFonts.rethinkSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Responsive.textScaleFactor * 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get the most recent record for this truck
                              if (controller.allTruckLogs.isNotEmpty) {
                                final mostRecentRecord =
                                    controller.allTruckLogs.first;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                          create: (context) =>
                                              EditTruckEntryController(),
                                          child: EditTruckEntryView(
                                            recordId: mostRecentRecord.id,
                                            truckNumber: widget.truckNumber,
                                          ),
                                        ),
                                  ),
                                );
                              }
                            },
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
                                style: GoogleFonts.rethinkSans(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Responsive.textScaleFactor * 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Filter Calendar Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Filter by Date",
                        style: GoogleFonts.rethinkSans(
                          fontWeight: FontWeight.bold,
                          fontSize: Responsive.textScaleFactor * 14,
                        ),
                      ),
                      Row(
                        children: [
                          // Date Filter Button
                          GestureDetector(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate:
                                    controller.selectedDate ?? DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: AppColor.primaryColor,
                                        onPrimary: AppColor.whiteColor,
                                        onSurface: AppColor.textColor,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null) {
                                controller.setSelectedDate(picked);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/calander.svg",
                                    width: 16,
                                    height: 16,
                                    colorFilter: ColorFilter.mode(
                                      AppColor.whiteColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    controller.selectedDate != null
                                        ? "${controller.selectedDate!.day}/${controller.selectedDate!.month}/${controller.selectedDate!.year}"
                                        : "Select Date",
                                    style: GoogleFonts.rethinkSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Responsive.textScaleFactor * 12,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          // Clear Filter Button
                          if (controller.selectedDate != null)
                            GestureDetector(
                              onTap: () {
                                controller.clearDateFilter();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.redColor,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 12.0,
                                ),
                                child: Text(
                                  "Clear",
                                  style: GoogleFonts.rethinkSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.textScaleFactor * 12,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Content Area
                  Expanded(child: _buildContent(controller)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(TruckLogDetailController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Error: ${controller.error}",
              style: GoogleFonts.rethinkSans(
                color: AppColor.redColor,
                fontSize: Responsive.textScaleFactor * 14,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (widget.truckNumber != null) {
                  controller.refreshData(widget.truckNumber!);
                }
              },
              child: Text("Retry"),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                if (widget.truckNumber != null) {
                  controller.debugLoadTruckLogs(widget.truckNumber!);
                }
              },
              child: Text("Debug Data"),
            ),
          ],
        ),
      );
    }

    if (controller.truckLogs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No logs found for this truck.",
              style: GoogleFonts.rethinkSans(
                fontSize: Responsive.textScaleFactor * 16,
                color: AppColor.textColor,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (widget.truckNumber != null) {
                  controller.refreshData(widget.truckNumber!);
                }
              },
              child: Text("Refresh"),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        if (widget.truckNumber != null) {
          await controller.refreshData(widget.truckNumber!);
        }
      },
      child: ListView.builder(
        itemCount: controller.truckLogs.length,
        itemBuilder: (context, index) {
          final record = controller.truckLogs[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: AppColor.filledColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Top Row: Date + Delete Icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/calander.svg"),
                            SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date: ${record.formattedDatef}",
                                  style: GoogleFonts.rethinkSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.textScaleFactor * 12,
                                  ),
                                ),
                                // Text(
                                //   "Timestamp: ${record.formattedTime}",
                                //   style: GoogleFonts.rethinkSans(
                                //     fontWeight: FontWeight.normal,
                                //     fontSize: Responsive.textScaleFactor * 10,
                                //   ),
                                // ),
                                Text(
                                  record.status,
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
                          onTap: () {
                            controller.deleteTruckLog(record.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.redColor.withOpacity(0.24),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/icons/delete-03.svg",
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Row(children: [Expanded(child: Divider())]),
                    const SizedBox(height: 8),

                    // Time Line Row
                    Column(
                      children: [
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
                                    fontSize: Responsive.textScaleFactor * 12,
                                  ),
                                ),
                                Text(
                                  record.formattedTimeIn ??
                                      record.formattedTime,
                                  style: GoogleFonts.rethinkSans(
                                    fontWeight: FontWeight.normal,
                                    fontSize: Responsive.textScaleFactor * 10,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColor.textColor,
                            ),
                            Expanded(
                              child: DottedLine(
                                dashLength: 4,
                                dashGapLength: 4,
                                lineThickness: 1,
                                dashColor: AppColor.textColor,
                              ),
                            ),
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: AppColor.textColor,
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time-Out",
                                  style: GoogleFonts.rethinkSans(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.textScaleFactor * 12,
                                  ),
                                ),
                                Text(
                                  record.formattedTimeOut,
                                  style: GoogleFonts.rethinkSans(
                                    fontWeight: FontWeight.normal,
                                    fontSize: Responsive.textScaleFactor * 10,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Total Time: ${record.totalTime}",
                          style: GoogleFonts.rethinkSans(
                            fontWeight: FontWeight.normal,
                            fontSize: Responsive.textScaleFactor * 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
