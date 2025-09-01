import 'package:acl/view/widgets/custom_textfield.dart';
import 'package:acl/viewmodel/settings_reset_password_view_model.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Clear any previous messages when view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChangePasswordModel>(context, listen: false).clearMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final changePasswordModel = Provider.of<ChangePasswordModel>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: _buildAppBar(),
      body: Consumer<ChangePasswordModel>(
        builder: (context, resetModel, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildStatusMessage(resetModel),
                  _buildCurrentPasswordField(changePasswordModel),
                  SizedBox(height: Responsive.h(1)),
                  _buildNewPasswordField(changePasswordModel, resetModel),
                  SizedBox(height: Responsive.h(1)),
                  _buildConfirmPasswordField(changePasswordModel, resetModel),
                  SizedBox(height: 16),
                  const Spacer(),
                  _buildSaveButton(changePasswordModel, resetModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------- APP BAR ----------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColor.whiteColor,
      centerTitle: true,
      title: Text(
        "Change Password",
        style: GoogleFonts.rethinkSans(fontWeight: FontWeight.bold),
      ),
    );
  }

  // ---------------- STATUS MESSAGES ----------------
  Widget _buildStatusMessage(ChangePasswordModel resetModel) {
    if (resetModel.errorMessage != null) {
      return _buildMessageBox(
        message: resetModel.errorMessage!,
        color: Colors.red,
      );
    }
    if (resetModel.successMessage != null) {
      return _buildMessageBox(
        message: resetModel.successMessage!,
        color: AppColor.primaryColor,
      );
    }
    return SizedBox.shrink();
  }

  Widget _buildMessageBox({required String message, required Color color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.filledColor),
      ),
      child: Text(
        message,
        style: GoogleFonts.rethinkSans(
          color: AppColor.filledColor,
          fontSize: 14,
        ),
      ),
    );
  }

  // ---------------- CURRENT PASSWORD FIELD ----------------
  Widget _buildCurrentPasswordField(ChangePasswordModel model) {
    return CustomTextField(
      controller: model.oldPasswordController,
      validator: model.validateOldPassword,
      iconPath: 'assets/icons/lock.svg',
      hintText: "Current Password",
    );
  }

  // ---------------- NEW PASSWORD FIELD ----------------
  Widget _buildNewPasswordField(
    ChangePasswordModel model,
    ChangePasswordModel resetModel,
  ) {
    return CustomTextField(
      controller: model.newPasswordController,
      hintText: 'New Password',
      iconPath: 'assets/icons/lock.svg',
      obscureText: true,
      onChanged: (value) {
        if (resetModel.errorMessage != null) {
          resetModel.clearMessages();
        }
        if (model.confirmPasswordController.text.isNotEmpty) {
          _formKey.currentState?.validate();
        }
      },
      validator: model.validateNewPassword,
    );
  }

  // ---------------- CONFIRM PASSWORD FIELD ----------------
  Widget _buildConfirmPasswordField(
    ChangePasswordModel model,
    ChangePasswordModel resetModel,
  ) {
    return CustomTextField(
      controller: model.confirmPasswordController,
      hintText: 'Confirm New Password',
      iconPath: 'assets/icons/lock.svg',
      obscureText: true,
      onChanged: (value) {
        if (resetModel.errorMessage != null) {
          resetModel.clearMessages();
        }
      },
      validator: model.validateConfirmPassword,
    );
  }

  // ---------------- SAVE BUTTON ----------------
  Widget _buildSaveButton(
    ChangePasswordModel changePasswordModel,
    ChangePasswordModel resetModel,
  ) {
    return AuthButton(
      buttonText: 'Save',
      loading: resetModel.isLoading,
      onPress: resetModel.isLoading
          ? () {}
          : () {
              if (_formKey.currentState!.validate()) {
                resetModel.reauthenticateAndChangePassword(
                  changePasswordModel.oldPasswordController.text,
                  changePasswordModel.newPasswordController.text,
                  changePasswordModel.confirmPasswordController.text,
                  context,
                );
              }
            },
    );
  }
}
