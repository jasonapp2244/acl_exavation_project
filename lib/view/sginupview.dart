import 'package:acl/controller/signup_view_model.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// ==================== VIEW =========================
class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Clear any previous errors when view loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SignupViewModel>(context, listen: false).clearError();
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
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topRight,
                    radius: 0.6,
                    focalRadius: 0.1,
                    colors: [Color(0xFF4EEED0), Color(0xFF111B19)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/images/login.svg"),
                    Text(
                      "Sign up for a new account",
                      style: GoogleFonts.rethinkSans(
                        fontSize: Responsive.textScaleFactor * 32,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Join us to explore the app",
                      style: GoogleFonts.rethinkSans(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                constraints: BoxConstraints(maxHeight: Responsive.h(60)),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                  child: Consumer<SignupViewModel>(
                    builder: (context, signupVM, child) {
                      return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Error Message
                            if (signupVM.errorMessage != null)
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
                                  signupVM.errorMessage!,
                                  style: GoogleFonts.rethinkSans(
                                    color: Colors.red.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),

                            // Full Name
                            TextFormField(
                              controller: fullNameController,
                              textCapitalization: TextCapitalization.words,
                              onChanged: (value) {
                                // Clear error when user starts typing
                                if (signupVM.errorMessage != null) {
                                  signupVM.clearError();
                                }
                              },
                              validator: (value) {
                                return signupVM.validateName(value ?? '');
                              },
                              decoration: _inputDecoration(
                                iconPath:
                                    "assets/icons/majesticons_mail (1).svg",
                                hint: "Full Name",
                              ),
                            ),
                            SizedBox(height: Responsive.h(1)),

                            // Email
                            TextFormField(
                              controller: emailAddressController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                // Clear error when user starts typing
                                if (signupVM.errorMessage != null) {
                                  signupVM.clearError();
                                }
                              },
                              validator: (value) {
                                return signupVM.validateEmail(value ?? '');
                              },
                              decoration: _inputDecoration(
                                iconPath:
                                    "assets/icons/majesticons_mail (1).svg",
                                hint: "Email Address",
                              ),
                            ),
                            SizedBox(height: Responsive.h(1)),

                            // Password
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              onChanged: (value) {
                                // Clear error when user starts typing
                                if (signupVM.errorMessage != null) {
                                  signupVM.clearError();
                                }
                              },
                              validator: (value) {
                                return signupVM.validatePassword(value ?? '');
                              },
                              decoration: _inputDecoration(
                                iconPath:
                                    "assets/icons/tabler_lock-filled (1).svg",
                                hint: "Password",
                              ),
                            ),
                            SizedBox(height: Responsive.h(1)),

                            // Password requirements info
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue.shade200),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Password Requirements:",
                                    style: GoogleFonts.rethinkSans(
                                      color: Colors.blue.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "• At least 6 characters long",
                                    style: GoogleFonts.rethinkSans(
                                      color: Colors.blue.shade700,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: Responsive.h(1)),

                            // Signup Button
                            GestureDetector(
                              onTap: signupVM.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        await signupVM.signup(
                                          fullNameController.text.trim(),
                                          emailAddressController.text.trim(),
                                          passwordController.text.trim(),
                                        );

                                        if (signupVM.errorMessage == null &&
                                            !signupVM.isLoading) {
                                          Navigator.pushReplacementNamed(
                                            context,
                                            RoutesName.main,
                                          );
                                        }
                                      }
                                    },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: signupVM.isLoading
                                      ? AppColor.primaryColor.withOpacity(0.6)
                                      : AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: signupVM.isLoading
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          "Signup",
                                          style: GoogleFonts.rethinkSans(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.h(2)),

                            // Divider
                            Row(
                              children: [
                                const Expanded(child: Divider()),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: const Text("OR"),
                                ),
                                const Expanded(child: Divider()),
                              ],
                            ),
                            SizedBox(height: Responsive.h(2)),

                            // Login Redirect
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                RoutesName.login,
                              ),
                              child: Text(
                                "Already have an account? Login here",
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

  InputDecoration _inputDecoration({
    required String iconPath,
    required String hint,
  }) {
    return InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(iconPath, width: 20, height: 20),
      ),
      hintText: hint,
      hintStyle: GoogleFonts.rethinkSans(color: AppColor.filletextdColor),
      filled: true,
      fillColor: AppColor.filledColor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.filledColor),
        borderRadius: BorderRadius.circular(22),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.filledColor),
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
