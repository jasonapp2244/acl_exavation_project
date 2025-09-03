import 'package:acl/viewmodel/truck_driver_model_view.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddTruckEnteryView extends StatelessWidget {
  const AddTruckEnteryView({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return ChangeNotifierProvider(
      create: (_) => TruckEntryViewModel(),
      child: Consumer<TruckEntryViewModel>(
        builder: (context, truckProvider, child) {
          return Scaffold(
            backgroundColor: AppColor.whiteColor,
            appBar: _buildAppBar(),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // _buildHeaderImage(),
                      //  SizedBox(height: Responsive.h(1)),
                      _buildDriverNameField(truckProvider),
                      SizedBox(height: Responsive.h(1)),
                      _buildAdditionalNotesField(truckProvider),
                      SizedBox(height: Responsive.h(1)),
                      _buildTruckNumberField(truckProvider),
                      SizedBox(height: Responsive.h(1)),
                      _buildLicensePlateUpload(truckProvider),
                      SizedBox(height: Responsive.h(2)),
                      _buildActionButtons(truckProvider, context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ------------------- AppBar -------------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.whiteColor,
      centerTitle: true,
      title: Text(
        "Add New Truck Entry",
        style: GoogleFonts.rethinkSans(fontWeight: FontWeight.bold),
      ),
    );
  }

  /// ------------------- Header Image -------------------
  Widget _buildHeaderImage() {
    return SvgPicture.asset("assets/images/Group 1171275573.svg");
  }

  /// ------------------- Driver Name Field -------------------
  Widget _buildDriverNameField(TruckEntryViewModel provider) {
    return TextFormField(
      controller: provider.driverNameController,
      onChanged: provider.setDriverName,
      decoration: _buildInputDecoration("Driver Name"),
    );
  }

  /// ------------------- Additional Notes Field -------------------
  Widget _buildAdditionalNotesField(TruckEntryViewModel provider) {
    return TextFormField(
      controller: provider.additionalController,
      maxLines: 3,
      onChanged: provider.setAdditionalNotes,
      decoration: _buildInputDecoration("Additional Notes (Optional)"),
    );
  }

  /// ------------------- Truck Number Field -------------------
  Widget _buildTruckNumberField(TruckEntryViewModel provider) {
    return TextFormField(
      controller: provider.truckNumberController,
      onChanged: provider.setTruckNumber,
      decoration: _buildInputDecoration("Truck Number"),
    );
  }

  /// ------------------- License Plate Upload -------------------
  Widget _buildLicensePlateUpload(TruckEntryViewModel provider) {
    return GestureDetector(
      onTap: () {
        // TODO: Implement photo picker
        // provider.setLicensePlatePhoto(selectedPath);
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
              style: GoogleFonts.rethinkSans(color: AppColor.filletextdColor),
            ),
          ],
        ),
      ),
    );
  }

  /// ------------------- Action Buttons -------------------
  Widget _buildActionButtons(
    TruckEntryViewModel provider,
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(child: _buildSaveButton(provider, context)),
        SizedBox(width: Responsive.w(1)),
        Expanded(child: _buildSaveTimeInButton(provider, context)),
      ],
    );
  }

  Widget _buildSaveButton(TruckEntryViewModel provider, BuildContext context) {
    return GestureDetector(
      onTap: provider.isSaveLoading ?? false
          ? null
          : () async {
              try {
                await provider.saveTruckEntry(context, recordTimeIn: false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Truck entry saved!")),
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: AppColor.primaryColor,
        ),
        child: Center(
          child: provider.isSaveLoading ?? false
              ? const CircularProgressIndicator(color: AppColor.whiteColor)
              : Text(
                  "Save",
                  style: GoogleFonts.rethinkSans(fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  Widget _buildSaveTimeInButton(
    TruckEntryViewModel provider,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: provider.isTimeInLoading ?? false
          ? null
          : () async {
              try {
                await provider.saveTruckEntry(context, recordTimeIn: true);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Truck entry saved & timed-in at ${provider.timeIn}",
                    ),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: AppColor.primaryColor,
        ),
        child: Center(
          child: provider.isTimeInLoading ?? false
              ? const CircularProgressIndicator(color: AppColor.whiteColor)
              : Text(
                  "Save & Time-In",
                  style: GoogleFonts.rethinkSans(fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  /// ------------------- Common Input Decoration -------------------
  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.rethinkSans(color: const Color(0xFFBDBDBD)),
      filled: true,
      fillColor: const Color(0xFFF5F5F5),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFF5F5F5)),
        borderRadius: BorderRadius.circular(22),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFF5F5F5)),
        borderRadius: BorderRadius.circular(22),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade300),
        borderRadius: BorderRadius.circular(22),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade500),
        borderRadius: BorderRadius.circular(22),
      ),
    );
  }
}
