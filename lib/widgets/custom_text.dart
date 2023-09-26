import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.colorText = Colors.black,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 18,

  });

  final String text;
  final Color colorText;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(text,style: GoogleFonts.poppins(
        fontWeight: fontWeight,
        fontSize: fontSize.sp,
        color: colorText,
    ));
  }
}
