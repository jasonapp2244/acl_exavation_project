import 'package:acl/controller/truck_driver_model_view.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTruckEnteryView extends StatelessWidget {
  const AddTruckEnteryView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return ChangeNotifierProvider(
      create: (_) => TruckEntryProvider(),
      child: Consumer<TruckEntryProvider>(
        builder: (context, truckProvider, child) {
          return Scaffold(
            backgroundColor: AppColor.whiteColor,
            appBar: AppBar(
              backgroundColor: AppColor.whiteColor,
              centerTitle: true,
              title: Text(
                "Add New Truck Entry",
                style: GoogleFonts.rethinkSans(fontWeight: FontWeight.bold),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SvgPicture.asset("assets/images/Group 1171275573.svg"),
                    SizedBox(height: Responsive.h(1)),

                    // Driver Name
                    TextFormField(
                      initialValue: truckProvider.driverName,
                      onChanged: truckProvider.setDriverName,
                      decoration: InputDecoration(
                        hintText: "Driver Name",
                        hintStyle: GoogleFonts.rethinkSans(
                          color: AppColor.filletextdColor,
                        ),
                        fillColor: AppColor.filledColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: AppColor.whiteColor),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.h(1)),

                    // Additional Notes
                    TextFormField(
                      initialValue: truckProvider.additionalNotes,
                      maxLines: 3,
                      onChanged: truckProvider.setAdditionalNotes,
                      decoration: InputDecoration(
                        hintText: "Additional Notes (Optional)",
                        hintStyle: GoogleFonts.rethinkSans(
                          color: AppColor.filletextdColor,
                        ),
                        fillColor: AppColor.filledColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(color: AppColor.whiteColor),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.h(1)),

                    // Truck Number
                    TextFormField(
                      initialValue: truckProvider.truckNumber,
                      onChanged: truckProvider.setTruckNumber,
                      decoration: InputDecoration(
                        hintText: "Truck Number",
                        hintStyle: GoogleFonts.rethinkSans(
                          color: AppColor.filletextdColor,
                        ),
                        fillColor: AppColor.filledColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(color: AppColor.whiteColor),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.h(1)),

                    // License Plate Photo Upload
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement photo picker
                        // truckProvider.setLicensePlatePhoto(selectedPath);
                      },
                      child: Container(
                        width: double.infinity,
                        height: Responsive.h(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: AppColor.filledColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/icons/camera-add-01.svg"),
                            Text(
                              "Upload License Plate Photo",
                              style: GoogleFonts.rethinkSans(
                                color: AppColor.filletextdColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Spacer(),
                    Row(
                      children: [
                        // Save Button
                        Expanded(
                          child: Consumer<TruckEntryProvider>(
                            builder: (context, truckProvider, child) {
                              return GestureDetector(
                                onTap: truckProvider.isSaveLoading ?? false
                                    ? null
                                    : () async {
                                        try {
                                          await truckProvider.saveTruckEntry(
                                            recordTimeIn: false,
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Truck entry saved!",
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(e.toString()),
                                            ),
                                          );
                                        }
                                      },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26),
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Center(
                                    child: truckProvider.isSaveLoading
                                        ? const CustomLoadingAnimation()
                                        : Text(
                                            "Save",
                                            style: GoogleFonts.rethinkSans(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: Responsive.w(1)),

                        // Save & Time-In Button
                        Expanded(
                          child: Consumer<TruckEntryProvider>(
                            builder: (context, truckProvider, child) {
                              return GestureDetector(
                                onTap: truckProvider.isTimeInLoading ?? false
                                    ? null
                                    : () async {
                                        try {
                                          await truckProvider.saveTruckEntry(
                                            recordTimeIn: true,
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Truck entry saved & timed-in at ${truckProvider.timeIn}",
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(e.toString()),
                                            ),
                                          );
                                        }
                                      },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(26),
                                    color: AppColor.primaryColor,
                                  ),
                                  child: Center(
                                    child:
                                        truckProvider.isTimeInLoading ?? false
                                        ? const CustomLoadingAnimation()
                                        : Text(
                                            "Save & Time-In",
                                            style: GoogleFonts.rethinkSans(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              );
                            },
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
