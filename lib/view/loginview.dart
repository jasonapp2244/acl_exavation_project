import 'package:acl/controller/forgot_password_view.dart';
import 'package:acl/controller/login_view_model.dart';
import 'package:acl/controller/logout_view_model.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Clear any previous errors when view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LoginViewModel>(context, listen: false).clearError();
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: Responsive.h(50)),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topRight,
                      radius: 0.6,
                      focalRadius: 0.1,
                      colors: [Color(0xFF4EEED0), Color(0xFF111B19)],
                    ),
                  ),
                  child: Padding(
                    padding: Responsive.padding(left: 4, right: 4, top: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(maxHeight: Responsive.h(60)),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                  child: Consumer<LoginViewModel>(
                    builder: (context, loginModel, child) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Error Message
                            if (loginModel.errorMessage != null)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.red.shade200,
                                  ),
                                ),
                                child: Text(
                                  loginModel.errorMessage!,
                                  style: GoogleFonts.rethinkSans(
                                    color: Colors.red.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                // Clear error when user starts typing
                                if (loginModel.errorMessage != null) {
                                  loginModel.clearError();
                                }
                              },
                              validator: (value) {
                                return loginModel.validateEmail(value ?? '');
                              },
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/majesticons_mail (1).svg",
                                  ),
                                ),
                                hintText: "Email Address",
                                hintStyle: GoogleFonts.rethinkSans(
                                  color: AppColor.filletextdColor,
                                ),
                                filled: true,
                                fillColor: AppColor.filledColor,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.filledColor,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.filledColor,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.h(2)),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              onChanged: (value) {
                                // Clear error when user starts typing
                                if (loginModel.errorMessage != null) {
                                  loginModel.clearError();
                                }
                              },
                              validator: (value) {
                                return loginModel.validatePassword(value ?? '');
                              },
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/tabler_lock-filled (1).svg",
                                  ),
                                ),
                                hintText: "Password",
                                hintStyle: GoogleFonts.rethinkSans(
                                  color: AppColor.filletextdColor,
                                ),
                                filled: true,
                                fillColor: AppColor.filledColor,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.filledColor,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColor.filledColor,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.h(2)),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _showForgotPasswordBottomSheet(context);
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: GoogleFonts.rethinkSans(
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Responsive.h(2)),
                            GestureDetector(
                              onTap: loginModel.isLoading
                                  ? null
                                  : () async {
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
                                child: Padding(
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
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.h(2)),
                            Row(
                              children: [
                                Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text("OR"),
                                ),
                                Expanded(child: Divider()),
                              ],
                            ),
                            SizedBox(height: Responsive.h(2)),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                RoutesName.signup,
                              ),
                              child: Text(
                                "Don't Have An Account? Signup Here",
                                style: GoogleFonts.rethinkSans(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showForgotPasswordBottomSheet(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var logoutModel = Provider.of<LogoutViewModel>(context, listen: false);
  var forgotPasswordModel = Provider.of<ForgotPasswordViewModel>(
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
                      color: AppColor.textdColor,
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
                  color: AppColor.textdColor,
                  fontSize: Responsive.sp(10),
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: Responsive.h(2)),
              SizedBox(
                height: Responsive.h(6),
                child: TextFormField(
                  style: TextStyle(color: AppColor.filletextdColor),
                  controller: emailController,
                  cursorColor: AppColor.primaryColor,
                  cursorErrorColor: AppColor.primaryColor,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                      borderSide: BorderSide(color: AppColor.filledColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                      borderSide: BorderSide(color: Colors.red.shade300),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                      borderSide: BorderSide(color: Colors.red.shade500),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.filledColor),
                      borderRadius: BorderRadius.circular(Responsive.w(12)),
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(Responsive.w(3)),
                      child: SvgPicture.asset("assets/icons/mail.svg"),
                    ),
                    filled: true,
                    fillColor: AppColor.filledColor,
                    hintText: "Email Address",
                    hintStyle: GoogleFonts.dmSans(
                      color: AppColor.filletextdColor,
                      fontWeight: FontWeight.normal,
                      fontSize: Responsive.sp(15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.h(2)),
              AuthButton(
                buttontext: "Send Reset Link",
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
