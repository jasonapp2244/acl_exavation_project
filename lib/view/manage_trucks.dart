import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageTrucks extends StatelessWidget {
  const ManageTrucks({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
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
                  padding: Responsive.padding(left: 4, right: 4, top: 2),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Manage Trucks",
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
                              "Sort By",
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
                                                Image(
                                                  width: 37,
                                                  height: 37,
                                                  image: AssetImage(
                                                    "assets/images/Ellipse 2@2x.png",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Responsive.w(1),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Driver Name",
                                                      style: GoogleFonts.rethinkSans(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize:
                                                            Responsive
                                                                .textScaleFactor *
                                                            12,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Carter Botosh",
                                                      style: GoogleFonts.rethinkSans(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Responsive
                                                                .textScaleFactor *
                                                            14,
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
                                                    RoutesName.eidtTruckEntry,
                                                  ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: AppColor.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(22),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 10.0,
                                                      ),
                                                  child: Text(
                                                    "Edit",
                                                    style: GoogleFonts.rethinkSans(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          Responsive
                                                              .textScaleFactor *
                                                          14,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: Responsive.h(1)),
                                        Row(
                                          children: [
                                            Expanded(child: Divider()),
                                          ],
                                        ),
                                        SizedBox(height: Responsive.h(1)),
                                        Row(
                                          spacing: 20,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                        Responsive
                                                            .textScaleFactor *
                                                        12,
                                                  ),
                                                ),
                                                Text(
                                                  "07:55 PM",
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
                                            Container(
                                              height:
                                                  20, // or match other elements in the row
                                              width: 1,
                                              color: AppColor.filletextdColor,
                                            ),
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
                                        SizedBox(height: Responsive.h(1)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
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
                                                  child: Center(
                                                    child: Text(
                                                      "View All Logs",
                                                      style:
                                                          GoogleFonts.rethinkSans(
                                                            color: AppColor
                                                                .textdColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: Responsive.w(1)),
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.redColor
                                                    .withValues(alpha: 0.24),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: SvgPicture.asset(
                                                  "assets/icons/delete-03.svg",
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
      ),
    );
  }
}
