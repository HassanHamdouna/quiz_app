import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/utils/context_extenssion.dart';
import 'package:quiz_app/widgets/custom_elevated_buttom.dart';
import 'package:quiz_app/widgets/custom_text.dart';
import 'package:quiz_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _nameTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                    child: CustomText(
                        text: 'Quizard',
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20.h),
                const CustomText(
                  text:
                      'quizzer to challenge you and your frinds on all topics',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  colorText: Colors.black45,
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hint: 'Name',
                  keyboardType: TextInputType.name,
                  controller: _nameTextController,
                ),
                SizedBox(height: 10.h),
                Center(
                  child: CustomElevatedButton(
                    textButton: 'Start playing',
                    onPressed: () => _performLogin(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/history_screen'),
                      child: const Text('show All player'),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_nameTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  void _login() async {
    Navigator.pushReplacementNamed(context, '/questions_screen');
  }

  void clearEditText() {
    _nameTextController.text = '';
  }
}
