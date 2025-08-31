import 'package:acl/controller/user_profile_controller.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EditProfileView extends StatefulWidget {
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Fetch user data when view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProfileController>(
        context,
        listen: false,
      ).fetchUserProfile();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.textdColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.rethinkSans(
            fontWeight: FontWeight.bold,
            color: AppColor.textdColor,
          ),
        ),
      ),
      body: Consumer<UserProfileController>(
        builder: (context, profileController, child) {
          // Update controllers with fetched data
          if (profileController.name.isNotEmpty &&
              nameController.text.isEmpty) {
            nameController.text = profileController.name;
            emailController.text = profileController.email;
            phoneController.text = profileController.phone;
            addressController.text = profileController.address;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                      width: 110,
                      height: 109,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.07),
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Main content area
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 40,
                                ),
                                profileController.getInitials(
                                  profileController.name.toString(),
                                ),
                              ),
                            ),
                          ),

                          // Edit icon in bottom right corner
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Loading indicator
                  if (profileController.isLoading)
                    Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),

                  // Error Message
                  if (profileController.errorMessage != null)
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
                        profileController.errorMessage!,
                        style: GoogleFonts.rethinkSans(
                          color: Colors.red.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  // Success Message
                  if (profileController.successMessage != null)
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
                        profileController.successMessage!,
                        style: GoogleFonts.rethinkSans(
                          color: AppColor.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  // Name Field
                  TextFormField(
                    controller: nameController,
                    style: GoogleFonts.rethinkSans(),
                    textCapitalization: TextCapitalization.words,
                    validator: profileController.validateName,
                    decoration: InputDecoration(
                      fillColor: AppColor.filledColor,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColor.filletextdColor,
                      ),
                      hintText: "Full Name",
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

                  // Email Field
                  TextFormField(
                    controller: emailController,
                    style: GoogleFonts.rethinkSans(),
                    keyboardType: TextInputType.emailAddress,
                    validator: profileController.validateEmail,
                    decoration: InputDecoration(
                      fillColor: AppColor.filledColor,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColor.filletextdColor,
                      ),
                      hintText: "Email Address",
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

                  // Phone Field
                  TextFormField(
                    controller: phoneController,
                    style: GoogleFonts.rethinkSans(),
                    keyboardType: TextInputType.phone,
                    validator: profileController.validatePhone,
                    decoration: InputDecoration(
                      fillColor: AppColor.filledColor,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: AppColor.filletextdColor,
                      ),
                      hintText: "Phone Number",
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

                  // Address Field
                  TextFormField(
                    controller: addressController,
                    style: GoogleFonts.rethinkSans(),
                    maxLines: 3,
                    validator: profileController.validateAddress,
                    decoration: InputDecoration(
                      fillColor: AppColor.filledColor,
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: Icon(
                          Icons.home,
                          color: AppColor.filletextdColor,
                        ),
                      ),
                      hintText: "Home Address",
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

                  // Save Button
                  AuthButton(
                    buttonText: 'Save Changes',
                    loading: profileController.isLoading,
                    onPress: profileController.isLoading
                        ? () {}
                        : () {
                            if (_formKey.currentState!.validate()) {
                              profileController.updateUserProfile(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                address: addressController.text,
                              );
                            }
                          },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
