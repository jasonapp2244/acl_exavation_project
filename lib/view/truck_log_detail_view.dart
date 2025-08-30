import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TruckLogDetailView extends StatelessWidget {
  const TruckLogDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,

        centerTitle: true,
        title: Text("Truck LHE-9023"),
      ),
      body: SafeArea(
        child: Padding(
          padding: Responsive.padding(left: 4, right: 4, top: 2, bottom: 4),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: AppColor.filledColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image(
                                width: 37,
                                height: 37,
                                image: AssetImage(
                                  "assets/images/Ellipse 2@2x.png",
                                ),
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
                                    "Carter Botosh",
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
                            onTap: () => Navigator.pushNamed(
                              context,
                              RoutesName.eidtTruckEntry,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Padding(
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Recent",
                    style: GoogleFonts.rethinkSans(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.textScaleFactor * 14,
                    ),
                  ),
                ],
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: ((context, index) {
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/calander.svg",
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Date: July 1, 2025",
                                            style: GoogleFonts.rethinkSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Responsive.textScaleFactor *
                                                  12,
                                            ),
                                          ),
                                          Text(
                                            "Departed",
                                            style: GoogleFonts.rethinkSans(
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  Responsive.textScaleFactor *
                                                  10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.redColor.withValues(
                                        alpha: 0.24,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        "assets/icons/delete-03.svg",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: Responsive.h(1)),
                              Row(children: [Expanded(child: Divider())]),
                              SizedBox(height: Responsive.h(1)),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                                  Responsive.textScaleFactor *
                                                  12,
                                            ),
                                          ),
                                          Text(
                                            "07:55 PM",
                                            style: GoogleFonts.rethinkSans(
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  Responsive.textScaleFactor *
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
                                                  Responsive.textScaleFactor *
                                                  12,
                                            ),
                                          ),
                                          Text(
                                            "09:10 PM",
                                            style: GoogleFonts.rethinkSans(
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  Responsive.textScaleFactor *
                                                  10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total Time: 2 hrs 30 mins",
                                        style: GoogleFonts.rethinkSans(
                                          fontWeight: FontWeight.normal,
                                          fontSize:
                                              Responsive.textScaleFactor * 10,
                                        ),
                                      ),
                                    ],
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
    );
  }
}
