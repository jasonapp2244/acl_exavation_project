import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? iconPath;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final IconData? icon;
  final String? initialValue;
  int? maxLines;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.iconPath,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.icon,
    this.initialValue,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines ?? 1,
      cursorColor: Color(0xFF4EEED0),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: icon != null
              ? Icon(icon, color: Colors.grey)
              : SvgPicture.asset(iconPath ?? ''),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.rethinkSans(color: const Color(0xFFBDBDBD)),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFF5F5F5)),
          borderRadius: BorderRadius.circular(22),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFF5F5F5)),
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
      ),
    );
  }
}
