import 'package:acl/controller/settings_reset_password_model.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Clear any previous messages when view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChangePasswordModel>(context, listen: false).clearMessages();
    });
  }

  // Validation methods
  String? _validateOldPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Current password is required';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'New password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: Text(
          "Change Password",
          style: GoogleFonts.rethinkSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ChangePasswordModel>(
        builder: (context, resetModel, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Error Message
                  if (resetModel.errorMessage != null)
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
                        resetModel.errorMessage!,
                        style: GoogleFonts.rethinkSans(
                          color: Colors.red.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  // Success Message
                  if (resetModel.successMessage != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Text(
                        resetModel.successMessage!,
                        style: GoogleFonts.rethinkSans(
                          color: Colors.green.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  // Current Password Field
                  TextFormField(
                    controller: oldPasswordController,
                    style: GoogleFonts.rethinkSans(),
                    obscureText: true,
                    onChanged: (value) {
                      // Clear error when user starts typing
                      if (resetModel.errorMessage != null) {
                        resetModel.clearMessages();
                      }
                    },
                    validator: _validateOldPassword,
                    decoration: InputDecoration(
                      fillColor: AppColor.filledColor,
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset("assets/icons/lock.svg"),
                      ),
                      hintText: "Current Password",
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: AppColor.filledColor),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(1)),

                  // New Password Field
                  TextFormField(
                    controller: newPasswordController,
                    style: GoogleFonts.rethinkSans(),
                    obscureText: true,
                    onChanged: (value) {
                      // Clear error when user starts typing
                      if (resetModel.errorMessage != null) {
                        resetModel.clearMessages();
                      }
                      // Trigger validation for confirm password when new password changes
                      if (confirmPasswordController.text.isNotEmpty) {
                        _formKey.currentState?.validate();
                      }
                    },
                    validator: _validateNewPassword,
                    decoration: InputDecoration(
                      fillColor: AppColor.filledColor,
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset("assets/icons/lock.svg"),
                      ),
                      hintText: "New Password",
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: AppColor.filledColor),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(1)),

                  // Confirm Password Field
                  TextFormField(
                    controller: confirmPasswordController,
                    style: GoogleFonts.rethinkSans(),
                    obscureText: true,
                    onChanged: (value) {
                      // Clear error when user starts typing
                      if (resetModel.errorMessage != null) {
                        resetModel.clearMessages();
                      }
                    },
                    validator: _validateConfirmPassword,
                    decoration: InputDecoration(
                      fillColor: AppColor.filledColor,
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset("assets/icons/lock.svg"),
                      ),
                      hintText: "Confirm New Password",
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
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(color: AppColor.filledColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Info text
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.blue.shade700,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Password must be at least 6 characters long",
                            style: GoogleFonts.rethinkSans(
                              color: Colors.blue.shade700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Spacer(),
                  AuthButton(
                    buttonText: 'Save',
                    loading: resetModel.isLoading,
                    onPress: resetModel.isLoading
                        ? () {}
                        : () {
                            if (_formKey.currentState!.validate()) {
                              resetModel.reauthenticateAndChangePassword(
                                oldPasswordController.text,
                                newPasswordController.text,
                                confirmPasswordController.text,
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
