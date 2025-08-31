import 'package:acl/controller/user_profile_controller.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/view/add_truck_entery_view.dart';
import 'package:acl/view/widgets/custom_driver_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  _HomeviewState createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
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

  // Helper method to get current date in the required format
  String _getCurrentDate() {
    final now = DateTime.now();
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final day = now.day.toString().padLeft(2, '0');
    final month = months[now.month - 1];
    final year = now.year.toString();
    return '$day $month $year';
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.secondaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: [
                Container(
                  height: 370,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.topRight,
                        radius: 0.6,
                        focalRadius: 0.1,
                        colors: [Color(0xFF4EEED0), Color(0xFF111B19)],
                      ), // Apply the gradient here
                    ),
                    child: Padding(
                      padding: Responsive.padding(left: 4, right: 4, top: 2),
                      child: Consumer<UserProfileController>(
                        builder: (context, profileController, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: AssetImage(
                                          "assets/images/Ellipse 2@2x.png",
                                        ),
                                      ),
                                      SizedBox(width: Responsive.w(2)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            profileController.name.isNotEmpty
                                                ? profileController.name
                                                : "Loading...",
                                            style: GoogleFonts.inter(
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            _getCurrentDate(),
                                            style: GoogleFonts.inter(
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: Responsive.h(1)),
                              Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
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
                                    // border: OutlineInputBorder(

                                    //   borderRadius: BorderRadius.circular(26)
                                    // )
                                  ),
                                ),
                              ),
                              SizedBox(height: Responsive.h(1)),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: AppColor.whiteColor.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Trucks",
                                        style: GoogleFonts.inter(
                                          fontSize:
                                              Responsive.textScaleFactor * 14,
                                          color: AppColor.whiteColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "28",
                                            style: GoogleFonts.inter(
                                              fontSize:
                                                  Responsive.textScaleFactor *
                                                  36,
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            "assets/images/truck.svg",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: Responsive.h(1)),

                              //Active Trucks On-Site and Departed Trucks
                              Row(
                                children: [
                                  Container(
                                    height: Responsive.h(12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color: AppColor.whiteColor.withValues(
                                        alpha: 0.2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Active Trucks On-Site",
                                            style: GoogleFonts.inter(
                                              fontSize:
                                                  Responsive.textScaleFactor *
                                                  12,
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            "6",
                                            style: GoogleFonts.inter(
                                              fontSize:
                                                  Responsive.textScaleFactor *
                                                  36,
                                              color: AppColor.whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Responsive.w(1)),
                                  Expanded(
                                    child: Container(
                                      height: Responsive.h(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        color: AppColor.whiteColor.withValues(
                                          alpha: 0.2,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Departed Trucks",
                                              style: GoogleFonts.inter(
                                                fontSize:
                                                    Responsive.textScaleFactor *
                                                    12,
                                                color: AppColor.whiteColor,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            Text(
                                              "13",
                                              style: GoogleFonts.inter(
                                                fontSize:
                                                    Responsive.textScaleFactor *
                                                    36,
                                                color: AppColor.whiteColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Responsive.h(1)),

                              AuthButton(
                                buttonText: 'Add New Truck Entry',
                                loading: false,
                                onPress: () {
                                  print('Add New Truck Entry button pressed');
                                  // Try direct navigation first
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddTruckEnteryView(),
                                    ),
                                  );
                                },
                                prefixIcon: SvgPicture.asset(
                                  "assets/icons/plus.svg",
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

        bottomSheet: Container(
          height:
              MediaQuery.of(context).size.height * 0.35, // 40% screen height
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Active Trucks On-Site",
                  style: GoogleFonts.rethinkSans(
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.textScaleFactor * 14,
                  ),
                ),

                Expanded(
                  child: Container(
                    height: 170,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: 13,
                      itemBuilder: (context, index) {
                        return CustomTruckEntryCardWidget(
                          truckNumber: "TRK-${100 + index}",
                          status: index % 2 == 0 ? "In Progress" : "Completed",
                          timeIn: "08:0${index} AM",
                          driverName: index % 2 == 0
                              ? "Abdullah Khan"
                              : "John Doe",
                          driverRole: index % 2 == 0 ? "Driver" : "Assistant",
                          onTimeOutPressed: () {
                            // Example action
                            print(
                              "Time Out pressed for truck TRK-${100 + index}",
                            );
                          },
                          onViewLogsPressed: () {
                            // Example action
                            print(
                              "View Logs pressed for truck TRK-${100 + index}",
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
