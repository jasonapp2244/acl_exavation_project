import 'package:acl/viewmodel/edit_truck_entry_model_view.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditTruckEntryView extends StatefulWidget {
  final String? recordId;
  final String? truckNumber;

  const EditTruckEntryView({super.key, this.recordId, this.truckNumber});

  @override
  State<EditTruckEntryView> createState() => _EditTruckEntryViewState();
}

class _EditTruckEntryViewState extends State<EditTruckEntryView> {
  final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _truckNumberController = TextEditingController();
  final TextEditingController _additionalNotesController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch truck record when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditTruckEntryController>().fetchTruckRecordByTruckNumber(
        widget.truckNumber!,
      );
    });
  }

  @override
  void dispose() {
    _driverNameController.dispose();
    _truckNumberController.dispose();
    _additionalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Edit Truck Entry",
          style: GoogleFonts.rethinkSans(
            fontWeight: FontWeight.bold,
            color: AppColor.textColor,
          ),
        ),
      ),
      body: Consumer<EditTruckEntryController>(
        builder: (context, controller, child) {
          // Update controllers with fetched data
          if (controller.driverName.isNotEmpty &&
              _driverNameController.text.isEmpty) {
            _driverNameController.text = controller.driverName;
            _truckNumberController.text = controller.truckNumber;
            _additionalNotesController.text = controller.additionalNotes;
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Loading indicator
                      if (controller.isLoading)
                        Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        ),

                      // Error Message
                      if (controller.error != null)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Text(
                            controller.error!,
                            style: GoogleFonts.rethinkSans(
                              color: Colors.red.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ),

                      // Success Message
                      if (controller.successMessage != null)
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColor.primaryColor),
                          ),
                          child: Text(
                            controller.successMessage!,
                            style: GoogleFonts.rethinkSans(
                              color: AppColor.whiteColor,
                              fontSize: 14,
                            ),
                          ),
                        ),

                      // Driver Name Field
                      TextFormField(
                        controller: _driverNameController,
                        style: GoogleFonts.rethinkSans(),
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Driver name is required';
                          }
                          return null;
                        },
                        onChanged: (value) => controller.setDriverName(value),
                        decoration: InputDecoration(
                          fillColor: AppColor.filledColor,
                          filled: true,

                          hintText: "Driver Name",
                          hintStyle: GoogleFonts.rethinkSans(
                            color: AppColor.filletextdColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: AppColor.filledColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: AppColor.filledColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: Colors.red.shade300),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: Colors.red.shade500),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(2)),

                      // Truck Number Field
                      TextFormField(
                        controller: _truckNumberController,
                        style: GoogleFonts.rethinkSans(),
                        textCapitalization: TextCapitalization.characters,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Truck number is required';
                          }
                          return null;
                        },
                        onChanged: (value) => controller.setTruckNumber(value),
                        decoration: InputDecoration(
                          fillColor: AppColor.filledColor,
                          filled: true,

                          hintText: "Truck Number",
                          hintStyle: GoogleFonts.rethinkSans(
                            color: AppColor.filletextdColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: AppColor.filledColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: AppColor.filledColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: Colors.red.shade300),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: Colors.red.shade500),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(2)),

                      // Additional Notes Field
                      TextFormField(
                        controller: _additionalNotesController,
                        style: GoogleFonts.rethinkSans(),
                        maxLines: 3,
                        onChanged: (value) =>
                            controller.setAdditionalNotes(value),
                        decoration: InputDecoration(
                          fillColor: AppColor.filledColor,
                          filled: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                          ),
                          hintText: "Additional Notes (Optional)",
                          hintStyle: GoogleFonts.rethinkSans(
                            color: AppColor.filletextdColor,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: AppColor.filledColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: AppColor.filledColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: Colors.red.shade300),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: BorderSide(color: Colors.red.shade500),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(3)),
                      _buildLicensePlateUpload(controller),
                      SizedBox(height: Responsive.h(2)),

                      // Save Button
                      AuthButton(
                        buttonText: 'Update Truck Entry',
                        loading: controller.isSaving,
                        onPress: controller.isSaving
                            ? () {}
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  controller.updateTruckRecordByTruckNumber(
                                    widget.truckNumber ?? '',
                                  );
                                }
                              },
                      ),
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

  // ------------------- License Plate Upload -------------------
  Widget _buildLicensePlateUpload(EditTruckEntryController provider) {
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
}
