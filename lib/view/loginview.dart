import 'package:acl/view/widgets/custom_textfield.dart';
import 'package:acl/viewmodel/forgot_password_model_view.dart';
import 'package:acl/viewmodel/login_view_model.dart';
import 'package:acl/viewmodel/logout_view_model.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/auth_button.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:acl/utils/routes/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Loginview extends StatefulWidget {
  @override
  _LoginviewState createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginModelViewModel>(context, listen: false).clearError();
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SingleChildScrollView(
        child: Column(children: [_buildHeader(), _buildFormSection()]),
      ),
    );
  }

  /// ================= HEADER WIDGET =================
  Widget _buildHeader() {
    return Container(
      constraints: BoxConstraints(maxHeight: Responsive.h(50)),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 0.6,
          focalRadius: 0.1,
          colors: [Color(0xFF4EEED0), Color(0xFF111B19)],
        ),
      ),
      padding: Responsive.padding(left: 4, right: 4, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset("assets/images/login.svg"),
          Text(
            "Login to your account",
            style: GoogleFonts.rethinkSans(
              fontSize: Responsive.textScaleFactor * 36,
              color: AppColor.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "login to explore about our app",
            style: GoogleFonts.rethinkSans(
              color: AppColor.whiteColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  /// ================= FORM SECTION =================
  Widget _buildFormSection() {
    return Container(
      constraints: BoxConstraints(maxHeight: Responsive.h(60)),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: Consumer<LoginModelViewModel>(
        builder: (context, loginModel, child) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _buildErrorMessage(loginModel),
                      _buildFormFields(loginModel),
                      SizedBox(height: Responsive.h(2)),
                      _buildForgotPasswordLink(),
                      SizedBox(height: Responsive.h(2)),
                      _buildLoginButton(loginModel),

                      // Fixed Signup link at bottom
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: Responsive.h(2)),
                  child: _buildSignupLink(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ================= ERROR MESSAGE =================
  Widget _buildErrorMessage(LoginModelViewModel loginModel) {
    if (loginModel.errorMessage == null) return SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              loginModel.errorMessage!,
              style: GoogleFonts.rethinkSans(
                color: Colors.red.shade700,
                fontSize: 14,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => loginModel.clearError(),
            child: Icon(Icons.close, color: Colors.red.shade700, size: 20),
          ),
        ],
      ),
    );
  }

  /// ================= FORM FIELDS =================
  Widget _buildFormFields(LoginModelViewModel loginModel) {
    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          hintText: "Email Address",
          iconPath: "assets/icons/majesticons_mail (1).svg",
          validator: (value) => loginModel.validateEmail(value ?? ''),
        ),
        SizedBox(height: Responsive.h(2)),
        CustomTextField(
          controller: passwordController,
          hintText: "Password",
          iconPath: "assets/icons/tabler_lock-filled (1).svg",
          obscureText: true,
          validator: (value) => loginModel.validatePassword(value ?? ''),
        ),
      ],
    );
  }

  /// ================= FORGOT PASSWORD =================
  Widget _buildForgotPasswordLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => _showForgotPasswordBottomSheet(context),
          child: Text(
            "Forgot Password?",
            style: GoogleFonts.rethinkSans(
              fontWeight: FontWeight.bold,
              color: AppColor.textColor,
            ),
          ),
        ),
      ],
    );
  }

  /// ================= LOGIN BUTTON =================
  Widget _buildLoginButton(LoginModelViewModel loginModel) {
    return GestureDetector(
      onTap: loginModel.isLoading
          ? null
          : () async {
              loginModel.clearError();
              if (_formKey.currentState!.validate()) {
                await loginModel.login(
                  emailController.text,
                  passwordController.text,
                  context,
                );
              }
            },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: loginModel.isLoading
              ? AppColor.primaryColor.withOpacity(0.6)
              : AppColor.primaryColor,
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: loginModel.isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  "Login",
                  style: GoogleFonts.rethinkSans(
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }

  /// ================= SIGNUP LINK =================

  Widget _buildSignupLink() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pushReplacementNamed(context, RoutesName.signup),
        child: RichText(
          text: TextSpan(
            text: "Don't Have An Account? ",
            style: GoogleFonts.rethinkSans(
              color: AppColor.textColor,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: "Signup Here",
                style: GoogleFonts.rethinkSans(
                  color: AppColor.textColor,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.textColor,
                  decorationThickness: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showForgotPasswordBottomSheet(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    var logoutModel = Provider.of<LogoutViewModel>(context, listen: false);
    var forgotPasswordModel = Provider.of<ForgotPasswordModelView>(
      context,
      listen: false,
    );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: AppColor.whiteColor,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: Responsive.w(5),
            right: Responsive.w(5),
            top: Responsive.h(3),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: GoogleFonts.rethinkSans(
                        color: AppColor.textColor,
                        fontSize: Responsive.sp(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/cross.svg"),
                    ),
                  ],
                ),
                Text(
                  "Enter your registered email address. We'll send you a link to reset your password.",
                  style: GoogleFonts.rethinkSans(
                    color: AppColor.textColor,
                    fontSize: Responsive.sp(10),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: Responsive.h(2)),
                SizedBox(
                  height: Responsive.h(6),
                  child: CustomTextField(
                    iconPath: "assets/icons/majesticons_mail (1).svg",
                    controller: emailController,

                    hintText: "Email Address",
                  ),
                ),

                SizedBox(height: Responsive.h(2)),
                AuthButton(
                  buttonText: "Send Reset Link",
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      await forgotPasswordModel.forgotPassword(
                        email: emailController.text,
                      );
                      Utils.flushBarErrorMassage("Reset link sent!", context);
                      Navigator.pop(context);
                    }
                  },
                  loading: false,
                ),
                SizedBox(height: Responsive.h(2)),
              ],
            ),
          ),
        );
      },
    );
  }
}
