import 'package:acl/view/widgets/custom_textfield.dart';
import 'package:acl/viewmodel/signup_view_model.dart';
import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

// // ==================== VIEW =========================
// class SignupView extends StatefulWidget {
//   @override
//   _SignupViewState createState() => _SignupViewState();
// }

// class _SignupViewState extends State<SignupView> {
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController emailAddressController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     // Clear any previous errors when view loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<SignupViewModel>(context, listen: false).clearError();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context);

//     return Scaffold(
//       backgroundColor: AppColor.secondaryColor,
//       body: Padding(
//         padding: const EdgeInsets.all(0.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 constraints: BoxConstraints(maxHeight: Responsive.h(50)),
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   gradient: RadialGradient(
//                     center: Alignment.topRight,
//                     radius: 0.6,
//                     focalRadius: 0.1,
//                     colors: [Color(0xFF4EEED0), Color(0xFF111B19)],
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset("assets/images/login.svg"),
//                     Text(
//                       "Sign up for a new account",
//                       style: GoogleFonts.rethinkSans(
//                         fontSize: Responsive.textScaleFactor * 32,
//                         color: AppColor.whiteColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "Join us to explore the app",
//                       style: GoogleFonts.rethinkSans(
//                         color: AppColor.whiteColor,
//                         fontWeight: FontWeight.normal,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Container(
//                 constraints: BoxConstraints(maxHeight: Responsive.h(60)),
//                 decoration: BoxDecoration(
//                   color: AppColor.whiteColor,
//                   borderRadius: BorderRadius.circular(22),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12.0,
//                     vertical: 16.0,
//                   ),
//                   child: Consumer<SignupViewModel>(
//                     builder: (context, signupVM, child) {
//                       return Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             // Error Message
//                             if (signupVM.errorMessage != null)
//                               Container(
//                                 width: double.infinity,
//                                 padding: EdgeInsets.all(12),
//                                 margin: EdgeInsets.only(bottom: 16),
//                                 decoration: BoxDecoration(
//                                   color: Colors.red.shade50,
//                                   borderRadius: BorderRadius.circular(8),
//                                   border: Border.all(
//                                     color: Colors.red.shade200,
//                                   ),
//                                 ),
//                                 child: Text(
//                                   signupVM.errorMessage!,
//                                   style: GoogleFonts.rethinkSans(
//                                     color: Colors.red.shade700,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),

//                             // Full Name
//                             CustomTextField(
//                               controller: fullNameController,
//                               iconPath: "assets/icons/person.svg",
//                               hintText: "Full Name",
//                               onChanged: (value) {
//                                 // Clear error when user starts typing
//                                 if (signupVM.errorMessage != null) {
//                                   signupVM.clearError();
//                                 }
//                               },
//                               validator: (value) {
//                                 return signupVM.validateName(value ?? '');
//                               },
//                             ),
//                             SizedBox(height: Responsive.h(1)),

//                             // Email
//                             CustomTextField(
//                               controller: emailAddressController,

//                               onChanged: (value) {
//                                 // Clear error when user starts typing
//                                 if (signupVM.errorMessage != null) {
//                                   signupVM.clearError();
//                                 }
//                               },
//                               validator: (value) {
//                                 return signupVM.validateEmail(value ?? '');
//                               },

//                               iconPath: "assets/icons/majesticons_mail (1).svg",
//                               hintText: "Email Address",
//                             ),
//                             SizedBox(height: Responsive.h(1)),

//                             // Password
//                             CustomTextField(
//                               controller: passwordController,
//                               obscureText: true,
//                               onChanged: (value) {
//                                 // Clear error when user starts typing
//                                 if (signupVM.errorMessage != null) {
//                                   signupVM.clearError();
//                                 }
//                               },
//                               validator: (value) {
//                                 return signupVM.validatePassword(value ?? '');
//                               },

//                               iconPath:
//                                   "assets/icons/tabler_lock-filled (1).svg",
//                               hintText: "Password",
//                             ),
//                             SizedBox(height: Responsive.h(1)),

//                             // Signup Button
//                             GestureDetector(
//                               onTap: signupVM.isLoading
//                                   ? null
//                                   : () async {
//                                       if (_formKey.currentState!.validate()) {
//                                         await signupVM.signup(
//                                           fullNameController.text.trim(),
//                                           emailAddressController.text.trim(),
//                                           passwordController.text.trim(),
//                                         );

//                                         if (signupVM.errorMessage == null &&
//                                             !signupVM.isLoading) {
//                                           Navigator.pushReplacementNamed(
//                                             context,
//                                             RoutesName.main,
//                                           );
//                                         }
//                                       }
//                                     },
//                               child: Container(
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: signupVM.isLoading
//                                       ? AppColor.primaryColor.withOpacity(0.6)
//                                       : AppColor.primaryColor,
//                                   borderRadius: BorderRadius.circular(22),
//                                 ),
//                                 padding: const EdgeInsets.all(16.0),
//                                 child: Center(
//                                   child: signupVM.isLoading
//                                       ? SizedBox(
//                                           height: 20,
//                                           width: 20,
//                                           child: CircularProgressIndicator(
//                                             color: Colors.white,
//                                             strokeWidth: 2,
//                                           ),
//                                         )
//                                       : Text(
//                                           "Signup",
//                                           style: GoogleFonts.rethinkSans(
//                                             fontSize: 18,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: Responsive.h(2)),

//                             // Divider
//                        _buildSignupLink(),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSignupLink() {
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: () => Navigator.pushReplacementNamed(context, RoutesName.login),
//         child: RichText(
//           text: TextSpan(
//             text: "Don't Have An Account? ",
//             style: GoogleFonts.rethinkSans(
//               color: AppColor.textdColor,
//               fontWeight: FontWeight.w400,
//             ),
//             children: [
//               TextSpan(
//                 text: "Signup Here",
//                 style: GoogleFonts.rethinkSans(
//                   color: AppColor.textdColor,
//                   fontWeight: FontWeight.bold,
//                   decoration: TextDecoration.underline,
//                   decorationColor: AppColor.textdColor,
//                   decorationThickness: 2,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration _inputDecoration({
//     required String iconPath,
//     required String hint,
//   }) {
//     return InputDecoration(
//       prefixIcon: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: SvgPicture.asset(iconPath, width: 20, height: 20),
//       ),
//       hintText: hint,
//       hintStyle: GoogleFonts.rethinkSans(color: AppColor.filletextdColor),
//       filled: true,
//       fillColor: AppColor.filledColor,
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: AppColor.filledColor),
//         borderRadius: BorderRadius.circular(22),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: AppColor.filledColor),
//         borderRadius: BorderRadius.circular(22),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.red.shade300),
//         borderRadius: BorderRadius.circular(22),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.red.shade500),
//         borderRadius: BorderRadius.circular(22),
//       ),
//     );
//   }
// }
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
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Column(
            children: [_buildHeaderSection(), _buildFormContainer()],
          ),
        ),
      ),
    );
  }

  // ------------------- HEADER SECTION -------------------
  Widget _buildHeaderSection() {
    return Container(
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
      padding: Responsive.padding(left: 4, right: 4, top: 10),
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
    );
  }

  // ------------------- FORM CONTAINER -------------------
  Widget _buildFormContainer() {
    return Container(
      constraints: BoxConstraints(maxHeight: Responsive.h(60)),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Consumer<SignupViewModel>(
          builder: (context, signupVM, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  if (signupVM.errorMessage != null)
                    _buildErrorMessage(signupVM.errorMessage!),
                  _buildNameField(signupVM),
                  SizedBox(height: Responsive.h(1)),
                  _buildEmailField(signupVM),
                  SizedBox(height: Responsive.h(1)),
                  _buildPasswordField(signupVM),
                  SizedBox(height: Responsive.h(1)),
                  _buildSignupButton(signupVM),
                  SizedBox(height: Responsive.h(2)),
                  _buildLoginLink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ------------------- ERROR MESSAGE -------------------
  Widget _buildErrorMessage(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Text(
        message,
        style: GoogleFonts.rethinkSans(
          color: Colors.red.shade700,
          fontSize: 14,
        ),
      ),
    );
  }

  // ------------------- NAME FIELD -------------------
  Widget _buildNameField(SignupViewModel signupVM) {
    return CustomTextField(
      controller: fullNameController,
      iconPath: "assets/icons/person.svg",
      hintText: "Full Name",
      onChanged: (_) => signupVM.clearError(),
      validator: (value) => signupVM.validateName(value ?? ''),
    );
  }

  // ------------------- EMAIL FIELD -------------------
  Widget _buildEmailField(SignupViewModel signupVM) {
    return CustomTextField(
      controller: emailAddressController,
      iconPath: "assets/icons/majesticons_mail (1).svg",
      hintText: "Email Address",
      onChanged: (_) => signupVM.clearError(),
      validator: (value) => signupVM.validateEmail(value ?? ''),
    );
  }

  // ------------------- PASSWORD FIELD -------------------
  Widget _buildPasswordField(SignupViewModel signupVM) {
    return CustomTextField(
      controller: passwordController,
      iconPath: "assets/icons/tabler_lock-filled (1).svg",
      hintText: "Password",
      obscureText: true,
      onChanged: (_) => signupVM.clearError(),
      validator: (value) => signupVM.validatePassword(value ?? ''),
    );
  }

  // ------------------- SIGNUP BUTTON -------------------
  Widget _buildSignupButton(SignupViewModel signupVM) {
    return GestureDetector(
      onTap: signupVM.isLoading
          ? null
          : () async {
              if (_formKey.currentState!.validate()) {
                await signupVM.signup(
                  fullNameController.text.trim(),
                  emailAddressController.text.trim(),
                  passwordController.text.trim(),
                );
                if (signupVM.errorMessage == null && !signupVM.isLoading) {
                  Navigator.pushReplacementNamed(context, RoutesName.main);
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
                    color: AppColor.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  // ------------------- LOGIN LINK -------------------
  Widget _buildLoginLink() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.pushReplacementNamed(context, RoutesName.login),
        child: RichText(
          text: TextSpan(
            text: "Don't Have An Account? ",
            style: GoogleFonts.rethinkSans(
              color: AppColor.textColor,
              fontWeight: FontWeight.w400,
            ),
            children: [
              TextSpan(
                text: "Login in",
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
}
