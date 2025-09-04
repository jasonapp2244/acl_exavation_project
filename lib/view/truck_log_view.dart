import 'package:acl/model/truck_driver_record_model.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/view/edit_truck_entry_view.dart';
import 'package:acl/view/truck_log_detail_view.dart';
import 'package:acl/view/widgets/custom_truck_log_card.dart';
import 'package:acl/viewmodel/edit_truck_entry_model_view.dart';
import 'package:acl/viewmodel/truck_log_detail_model_view.dart';
import 'package:acl/viewmodel/truck_logs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TruckLogView extends StatelessWidget {
  const TruckLogView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TruckLogsViewModel>(context, listen: true);
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
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.searchTruck,
                                );
                              },
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Showing logs from",
                            style: GoogleFonts.rethinkSans(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.textScaleFactor * 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Date Filter Button
                                  GestureDetector(
                                    onTap: () async {
                                      final DateTime?
                                      picked = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            controller.selectedDate ??
                                            DateTime.now(),
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
                                              fontSize:
                                                  Responsive.textScaleFactor *
                                                  12,
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
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 12.0,
                                        ),
                                        child: Text(
                                          "Clear",
                                          style: GoogleFonts.rethinkSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                Responsive.textScaleFactor * 12,
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      Expanded(
                        child: StreamBuilder<List<TruckDriverRecordModel>>(
                          stream: controller.latestLogsForDateStream(
                            date: controller.selectedDate ?? DateTime.now(),
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
                                  status: log.status,
                                  id: log.id,
                                  driverName: log.driverName,
                                  role: 'Driver',
                                  truckNumber: log.truckNumber,
                                  totalLogs: log.totalLogs ?? 0,
                                  timeIn: log.timeIn.toString(),
                                  timeOut: log.timeOut.toString(),
                                  onDelete: () async {
                                    await controller.deleteTruckEntry(
                                      log.truckNumber,
                                    );
                                  },
                                  onEdit: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                              create: (context) =>
                                                  EditTruckEntryModelView(),
                                              child: EditTruckEntryView(
                                                truckNumber: log.truckNumber,
                                              ),
                                            ),
                                      ),
                                    );
                                  },
                                  onViewLogs: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                              create: (context) =>
                                                  TruckLogDetailViewModel(),
                                              child: TruckLogDetailView(
                                                truckNumber: log.truckNumber,
                                              ),
                                            ),
                                      ),
                                    );
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
