import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/widgets/custom_text.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3),() {
      Navigator.pushReplacementNamed(context, '/login_screen');
    },);
  }
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:  Center(
        child:  CustomText(text: 'welcome QUIZ APP'),
      ),
    );
  }
}

