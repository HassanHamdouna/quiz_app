import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.textButton,
    required this.onPressed,
    this.width = double.infinity,
  });

  final String textButton;
  final Function()? onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, 50.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r))),
      child: Text(
        textButton,
        style: GoogleFonts.poppins(),
      ),
    );
  }
}
