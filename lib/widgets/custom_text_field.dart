import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hint,
    this.prefixIcon,
    required this.keyboardType,
    required this.controller,
    this.focusedBorderColor = Colors.grey,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  final String hint;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Color focusedBorderColor;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.cairo(fontSize: 13.sp),
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.w),
        hintText: hint,
        hintStyle: GoogleFonts.cairo(fontSize: 13.sp),
        hintMaxLines: 1,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(color: focusedBorderColor),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(color: color),
    );
  }
}