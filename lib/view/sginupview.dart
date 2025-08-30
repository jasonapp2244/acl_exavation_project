import 'package:acl/res/components/app_color.dart';
import 'package:acl/res/components/responsive.dart';
import 'package:acl/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Sginupview extends StatelessWidget {
  const Sginupview({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topRight,
                    radius: 0.6,
                    focalRadius: 0.1,
                    colors: [Color(0xFF4EEED0), Color(0xFF111B19)],
                  ), // Apply the gradient here
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/images/login.svg"),
                    Text(
                      "Sign in to your account",
                      style: GoogleFonts.rethinkSans(
                        fontSize: Responsive.textScaleFactor * 36,
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sign in to explore about our app",
                      style: GoogleFonts.rethinkSans(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefix: SvgPicture.asset(
                            "assets/icons/majesticons_mail (1).svg",
                          ),
                          hint: Text(
                            "Full Name",
                            style: GoogleFonts.rethinkSans(
                              color: AppColor.filletextdColor,
                            ),
                          ),
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
                            borderSide: BorderSide(color: AppColor.filledColor),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.filledColor),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          // border: OutlineInputBorder(

                          //   borderRadius: BorderRadius.circular(26)
                          // )
                        ),
                      ),
                      SizedBox(height: Responsive.h(1)),
                      TextFormField(
                        decoration: InputDecoration(
                          prefix: SvgPicture.asset(
                            "assets/icons/majesticons_mail (1).svg",
                          ),
                          hint: Text(
                            "Email Address",
                            style: GoogleFonts.rethinkSans(
                              color: AppColor.filletextdColor,
                            ),
                          ),
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
                            borderSide: BorderSide(color: AppColor.filledColor),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.filledColor),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          // border: OutlineInputBorder(

                          //   borderRadius: BorderRadius.circular(26)
                          // )
                        ),
                      ),
                      SizedBox(height: Responsive.h(1)),
                      TextFormField(
                        decoration: InputDecoration(
                          prefix: SvgPicture.asset(
                            "assets/icons/tabler_lock-filled (1).svg",
                          ),
                          hint: Text(
                            "Password",
                            style: GoogleFonts.rethinkSans(
                              color: AppColor.filletextdColor,
                            ),
                          ),
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
                            borderSide: BorderSide(color: AppColor.filledColor),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor.filledColor),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          // border: OutlineInputBorder(

                          //   borderRadius: BorderRadius.circular(26)
                          // )
                        ),
                      ),
                    
                      SizedBox(height: Responsive.h(1)),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Signup")),
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.filledColor,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(width: Responsive.w(20)),
                                SvgPicture.asset("assets/icons/google.svg"),
                                SizedBox(width: Responsive.w(1.5)),
                                Text("Continue With Google"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(1)),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.facebokkColor,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              children: [
                                SizedBox(width: Responsive.w(20)),
                                SvgPicture.asset("assets/icons/facebook.svg"),
                                SizedBox(width: Responsive.w(1)),
                                Text("Continue With Facebook"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(2)),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, RoutesName.login),
                        child: Text("Have An Account? Login Here")),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

















// import 'package:app/res/components/auth_button.dart';
// import 'package:app/utils/routes/routes_name.dart';
// import 'package:app/utils/routes/utils.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../viewmodel/auth_viewmodel.dart';

// class Sginupview extends StatefulWidget {
//   const Loginview({super.key});

//   @override
//   State<Loginview> createState() => _LoginviewState();
// }

// class _LoginviewState extends State<Loginview> {
//   final ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   FocusNode emailFoucsNode = FocusNode();
//   FocusNode passwordFoucsNode = FocusNode();
//   FocusNode sumbitFoucsNode = FocusNode();
//   @override
//   void dispose() {
//     super.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     passwordFoucsNode.dispose();
//     emailFoucsNode.dispose();
//     _obsecurePassword.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authViewmodel = Provider.of<AuthViewmodel>(context);
//     final height = MediaQuery.of(context).size.height * 1;
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailController,
//               focusNode: emailFoucsNode,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                   hintText: "Email",
//                   label: Text("Email"),
//                   prefix: Icon(Icons.alternate_email)),
//               onFieldSubmitted: (value) {
//                 Utils.fieldFoucsChange(
//                     context, emailFoucsNode, passwordFoucsNode);
//               },
//             ),
//             SizedBox(height: height * 0.1),
//             ValueListenableBuilder(
//               valueListenable: _obsecurePassword,
//               builder: (context, value, child) {
//                 return TextFormField(
//                   controller: passwordController,
//                   focusNode: passwordFoucsNode,
//                   obscureText: _obsecurePassword.value,
//                   //  value,
//                   obscuringCharacter: "*",
//                   decoration: InputDecoration(
//                     hintText: "Password",
//                     label: Text("Password"),
//                     prefix: Icon(Icons.lock),
//                     suffixIcon: InkWell(
//                         onTap: () {
//                           _obsecurePassword.value = !_obsecurePassword.value;
//                         },
//                         child: Icon(_obsecurePassword.value
//                             ? Icons.visibility_off
//                             : Icons.visibility)),
//                   ),
//                   // onFieldSubmitted: (valuw) {
//                   //   Utils.fieldFoucsChange(
//                   //       context, passwordFoucsNode, sumbitFoucsNode);
//                   // },
//                 );
//               },
//             ),
//             SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
//             AuthButton(
              
//                 buttontext: "Login",
//                 loading: authViewmodel.loading,
//                 onPress: () {
//                   if (emailController.text.isEmpty) {
//                     Utils.flushBarErrorMassage(
//                         "Please Enter Email First", context);
//                   } else if (passwordController.text.isEmpty) {
//                     Utils.flushBarErrorMassage(
//                         "Please Enter Password First", context);
//                   } else if (passwordController.text.length < 8) {
//                     Utils.flushBarErrorMassage(
//                         "Please Enter 8 digeits", context);
//                   } else {
//                     Map<String, String> headr = {"x-api-key": "reqres-free-v1"};
//                     Map data = {
//                       'email': emailController.text.toString(),
//                       'password': passwordController.text.toString()
//                     };
//                     authViewmodel.loginApi(data, headr, context);
//                   }
//                 }), Text.rich(textAlign: TextAlign.center,
//                   TextSpan(
//                     text: "Already have an account?",
//                     style: TextStyle(color: Colors.black, fontSize: 16),
//                     children: [
//                       TextSpan(
//                         text: "Login",
//                         style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             Navigator.pushNamed(context, RoutesName.login);
//                           },
//                       )
//                     ],
//                   )),
//           ],
//         ),
//       ),
//     );
//   }
// }
