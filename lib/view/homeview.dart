import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key});

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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    children: [
                                      Text(
                                        "Michel Smith.",
                                        style: GoogleFonts.inter(
                                          color: AppColor.whiteColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "02 July 2025",
                                        style: GoogleFonts.inter(
                                          color: AppColor.whiteColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.whiteColor.withValues(
                                    alpha: 0.2,
                                  ),
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
                              color: AppColor.whiteColor.withValues(alpha: 0.2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Trucks",
                                    style: GoogleFonts.inter(
                                      fontSize: Responsive.textScaleFactor * 14,
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
                                              Responsive.textScaleFactor * 36,
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
                                              Responsive.textScaleFactor * 12,
                                          color: AppColor.whiteColor,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        "6",
                                        style: GoogleFonts.inter(
                                          fontSize:
                                              Responsive.textScaleFactor * 36,
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
                                                Responsive.textScaleFactor * 12,
                                            color: AppColor.whiteColor,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          "13",
                                          style: GoogleFonts.inter(
                                            fontSize:
                                                Responsive.textScaleFactor * 36,
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
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: AppColor.primaryColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset("assets/icons/plus.svg"),
                                    SizedBox(width: Responsive.w(1)),
                                    Text(
                                      "Add New Truck Entry",
                                      style: GoogleFonts.rethinkSans(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            Responsive.textScaleFactor * 16,
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

                      itemBuilder: ((context, index) {
                        return Column(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/truck.svg",
                                            ),
                                            SizedBox(width: 5),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Truck No",
                                                  style: GoogleFonts.rethinkSans(
                                                    fontWeight: FontWeight.bold,
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
                                    Row(children: [Expanded(child: Divider())]),
                                    SizedBox(height: Responsive.h(1)),
                                    Row(
                                      children: [
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
                                      ],
                                    ),
                                    SizedBox(height: Responsive.h(1)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            CircleAvatar(),

                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Ruben Mango",
                                                  style: GoogleFonts.rethinkSans(
                                                    fontWeight: FontWeight.bold,
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

                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.primaryColor,
                                            borderRadius: BorderRadius.circular(
                                              22,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text("View All Logs"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // SlideToActWidget(),
                                    SizedBox(height: Responsive.h(1)),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text("Press to Time Out"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        );
                      }),
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
