import 'package:acl/view/widgets/custom_textfield.dart';
import 'package:acl/viewmodel/user_profile_model_view.dart';
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
      appBar: _buildAppBar(context),
      body: Consumer<UserProfileController>(
        builder: (context, profileController, child) {
          _populateFields(profileController);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileAvatar(profileController),
                    const SizedBox(height: 16),
                    if (profileController.isLoading)
                      _buildLoadingIndicator()
                    else ...[
                      _buildErrorMessage(profileController),
                      _buildSuccessMessage(profileController),
                      _buildFormFields(profileController),
                      SizedBox(height: Responsive.h(3)),
                      _buildSaveButton(profileController),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ------------------- AppBar -------------------
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.whiteColor,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColor.textColor),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Edit Profile",
        style: GoogleFonts.rethinkSans(
          fontWeight: FontWeight.bold,
          color: AppColor.textColor,
        ),
      ),
    );
  }

  /// ------------------- Populate Fields -------------------
  void _populateFields(UserProfileController controller) {
    if (controller.name.isNotEmpty && nameController.text.isEmpty) {
      nameController.text = controller.name;
      emailController.text = controller.email;
      phoneController.text = controller.phone;
      addressController.text = controller.address;
    }
  }

  /// ------------------- Avatar -------------------
  Widget _buildProfileAvatar(UserProfileController controller) {
    return GestureDetector(
      child: Container(
        width: 110,
        height: 109,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.07), width: 1),
        ),
        child: Center(
          child: Text(
            controller.getInitials(controller.name.toString()),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
          ),
        ),
      ),
    );
  }

  /// ------------------- Loading Indicator -------------------
  Widget _buildLoadingIndicator() {
    return Center(child: CircularProgressIndicator(color: AppColor.whiteColor));
  }

  /// ------------------- Error Message -------------------
  Widget _buildErrorMessage(UserProfileController controller) {
    if (controller.errorMessage == null) return SizedBox.shrink();
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
        controller.errorMessage!,
        style: GoogleFonts.rethinkSans(
          color: Colors.red.shade700,
          fontSize: 14,
        ),
      ),
    );
  }

  /// ------------------- Success Message -------------------
  Widget _buildSuccessMessage(UserProfileController controller) {
    if (controller.successMessage == null) return SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
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
    );
  }

  /// ------------------- Form Fields -------------------
  Widget _buildFormFields(UserProfileController controller) {
    return Column(
      children: [
        CustomTextField(
          controller: nameController,
          validator: controller.validateName,
          icon: Icons.person,
          hintText: "Full Name",
          iconPath: '',
        ),
        SizedBox(height: Responsive.h(2)),
        CustomTextField(
          controller: emailController,
          validator: controller.validateEmail,
          icon: Icons.email,
          hintText: "Email Address",
          iconPath: '',
        ),
        SizedBox(height: Responsive.h(2)),
        CustomTextField(
          controller: phoneController,
          validator: controller.validatePhone,
          icon: Icons.phone,
          hintText: "Phone Number",
          iconPath: '',
        ),
        SizedBox(height: Responsive.h(2)),
        CustomTextField(
          controller: addressController,
          validator: controller.validateAddress,
          icon: Icons.home,
          hintText: "Home Address",
          iconPath: '',
        ),
      ],
    );
  }

  /// ------------------- Save Button -------------------
  Widget _buildSaveButton(UserProfileController controller) {
    return AuthButton(
      buttonText: 'Save Changes',
      loading: controller.isLoading,
      onPress: controller.isLoading
          ? () {}
          : () {
              if (_formKey.currentState!.validate()) {
                controller.updateUserProfile(
                  name: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                  context: context,
                );
              }
            },
    );
  }
}
