import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/widgets/custom_elevated_buttom.dart';
import 'package:quiz_app/widgets/custom_option_card.dart';
import 'package:quiz_app/widgets/custom_text.dart';

class QuestionsScreen extends StatefulWidget {
   const QuestionsScreen({super.key, this.studentName});
  final String? studentName ;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final bool isClicked = false;

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
                  text: 'Question 3 out of 10',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  colorText: Colors.black45,
                )),
                SizedBox(height: 20.h),
                const Center(
                    child: CustomText(
                        text:
                            'How many Wizards Were Killed in making of uizard',
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 20.h),
                CustomOptionCard(
                    textOption: '20',
                    colorOption: isClicked ? Colors.green : Colors.white10),
                CustomOptionCard(
                    textOption: '100',
                    colorOption: isClicked ? Colors.green : Colors.white10),
                CustomOptionCard(
                    textOption: '40',
                    colorOption: isClicked ? Colors.green : Colors.white10),
                CustomOptionCard(
                    textOption: '50',
                    colorOption: isClicked ? Colors.green : Colors.white10),
                SizedBox(height: 20.h),
                CustomElevatedButton(
                  textButton: 'Next Questions',
                  onPressed: () {},
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
}
