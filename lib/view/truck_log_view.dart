import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:dotted_line/dotted_line.dart';
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
                              color: AppColor.textdColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.textScaleFactor * 16,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 15,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: AppColor.filledColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/truck.svg",
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Truck No",
                                                    style: GoogleFonts.rethinkSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Responsive
                                                              .textScaleFactor *
                                                          12,
                                                    ),
                                                  ),
                                                  Text(
                                                    "LHE-2233",
                                                    style: GoogleFonts.rethinkSans(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize:
                                                          Responsive
                                                              .textScaleFactor *
                                                          10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Text("On Site"),
                                        ],
                                      ),
                                      SizedBox(height: Responsive.h(1)),
                                      Row(
                                        children: [Expanded(child: Divider())],
                                      ),
                                      SizedBox(height: Responsive.h(1)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Left Circle
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Time-In",
                                                style: GoogleFonts.rethinkSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Responsive
                                                          .textScaleFactor *
                                                      12,
                                                ),
                                              ),
                                              Text(
                                                "07:55 PM",
                                                style: GoogleFonts.rethinkSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize:
                                                      Responsive
                                                          .textScaleFactor *
                                                      10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: AppColor.textdColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          // SizedBox(width: 5),
                                          // Dotted Line
                                          Expanded(
                                            child: DottedLine(
                                              dashLength: 4,
                                              dashGapLength: 4,
                                              lineThickness: 1,
                                              dashColor: AppColor.textdColor,
                                            ),
                                          ),
                                          // SizedBox(width: 5),
                                          // Right Circle
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: AppColor.textdColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Time-Out",
                                                style: GoogleFonts.rethinkSans(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Responsive
                                                          .textScaleFactor *
                                                      12,
                                                ),
                                              ),
                                              Text(
                                                "09:10 PM",
                                                style: GoogleFonts.rethinkSans(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize:
                                                      Responsive
                                                          .textScaleFactor *
                                                      10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: Responsive.h(1)),
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
                                              SizedBox(width: Responsive.w(1)),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Ruben Mango",
                                                    style: GoogleFonts.rethinkSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Responsive
                                                              .textScaleFactor *
                                                          12,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Driver",
                                                    style: GoogleFonts.rethinkSans(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize:
                                                          Responsive
                                                              .textScaleFactor *
                                                          10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  RoutesName.truckLogDetail,
                                                ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: AppColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  6.0,
                                                ),
                                                child: Text(
                                                  "View All Logs",
                                                  style:
                                                      GoogleFonts.rethinkSans(
                                                        color:
                                                            AppColor.textdColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
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
                            );
                          }),
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
