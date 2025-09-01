import 'package:acl/view/widgets/custom_textfield.dart';
import 'package:acl/viewmodel/change_email_model_view.dart';
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
  final TextEditingController changeEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChangeEmailModelView>(context, listen: false).clearMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: _buildAppBar(),
      body: Consumer<ChangeEmailModelView>(
        builder: (context, changeEmail, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildErrorMessage(changeEmail),
                  _buildSuccessMessage(changeEmail),
                  _buildEmailField(changeEmail),
                  const SizedBox(height: 16),
                  _buildInfoBox(),
                  Spacer(),
                  _buildSaveButton(changeEmail),
                ],
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
        "Change Email Address",
        style: GoogleFonts.rethinkSans(fontWeight: FontWeight.bold),
      ),
    );
  }

  /// ------------------- Error Message -------------------
  Widget _buildErrorMessage(ChangeEmailModelView changeEmail) {
    if (changeEmail.errorMessage == null) return SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
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
    );
  }

  /// ------------------- Success Message -------------------
  Widget _buildSuccessMessage(ChangeEmailModelView changeEmail) {
    if (changeEmail.successMessage == null) return SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Text(
        changeEmail.successMessage!,
        style: GoogleFonts.rethinkSans(
          color: AppColor.primaryColor,
          fontSize: 14,
        ),
      ),
    );
  }

  /// ------------------- Email Field -------------------
  Widget _buildEmailField(ChangeEmailModelView changeEmail) {
    return CustomTextField(
      iconPath: 'assets/icons/majesticons_mail (1).svg',
      controller: changeEmailController,
      onChanged: (value) {
        if (changeEmail.errorMessage != null) {
          changeEmail.clearMessages();
        }
      },
      validator: changeEmail.validateEmail,
      hintText: "New Email Address",
    );
  }

  /// ------------------- Info Box -------------------
  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
          const SizedBox(width: 8),
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
    );
  }

  /// ------------------- Save Button -------------------
  Widget _buildSaveButton(ChangeEmailModelView changeEmail) {
    return AuthButton(
      buttonText: 'Save',
      loading: changeEmail.isLoading,
      onPress: changeEmail.isLoading
          ? () {}
          : () {
              if (_formKey.currentState!.validate()) {
                changeEmail.changeEmail(changeEmailController.text);
              }
            },
    );
  }
}
