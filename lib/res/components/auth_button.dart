import 'package:acl/res/components/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthButton extends StatelessWidget {
  final String? buttontext;
  final bool loading;
  final VoidCallback onPress;
  const AuthButton({
    super.key,
    required this.buttontext,
    required this.loading,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        //  MediaQuery.sizeOf(context).width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColor.primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: loading
                ? CustomLoadingAnimation()
                : Text(
                    buttontext.toString(),
                    style: GoogleFonts.rethinkSans(
                      color: AppColor.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomLoadingAnimation extends StatelessWidget {
  const CustomLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: Colors.white,
      size: MediaQuery.sizeOf(context).height * 0.02,
    );
  }
}
