import 'package:acl/res/components/app_color.dart';
import 'package:acl/view/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final bool loading;
  final VoidCallback onPress;
  final Widget? prefixIcon; // optional icon before text

  const AuthButton({
    super.key,
    required this.buttonText,
    required this.loading,
    required this.onPress,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPress, // disable button when loading
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: AppColor.primaryColor,
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Optional icon first
              if (prefixIcon != null) ...[
                prefixIcon!,
                const SizedBox(width: 8),
              ],

              // Label
              Text(
                buttonText,
                style: GoogleFonts.rethinkSans(
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Loading indicator after text
              if (loading) ...[
                const SizedBox(width: 8),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CustomLoading()
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

