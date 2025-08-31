import 'package:acl/controller/change_email_model_view.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangeEmailView extends StatefulWidget {
  @override
  _ChangeEmailViewState createState() => _ChangeEmailViewState();
}

class _ChangeEmailViewState extends State<ChangeEmailView> {
  TextEditingController changeEmailController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Clear any previous messages when view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChangeEmailModelView>(context, listen: false).clearMessages();
    });
  }

  // Validation method
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        centerTitle: true,
        title: Text(
          "Change Email Address",
          style: GoogleFonts.rethinkSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ChangeEmailModelView>(
        builder: (context, changeEmail, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Error Message
                  if (changeEmail.errorMessage != null)
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
                        changeEmail.errorMessage!,
                        style: GoogleFonts.rethinkSans(
                          color: Colors.red.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  // Success Message
                  if (changeEmail.successMessage != null)
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
                        changeEmail.successMessage!,
                        style: GoogleFonts.rethinkSans(
                          color: Colors.green.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),

                  // Email Field
                  TextFormField(
                    controller: changeEmailController,
                    style: GoogleFonts.rethinkSans(),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      // Clear error when user starts typing
                      if (changeEmail.errorMessage != null) {
                        changeEmail.clearMessages();
                      }
                    },
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      fillColor: AppColor.filledColor,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColor.filletextdColor,
                      ),
                      hintText: "New Email Address",
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
                            "You'll need to verify your current email before changing it",
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
                    loading: changeEmail.isLoading,
                    onPress: changeEmail.isLoading
                        ? () {}
                        : () {
                            if (_formKey.currentState!.validate()) {
                              changeEmail.changeEmail(
                                changeEmailController.text,
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
