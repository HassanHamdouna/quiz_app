import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz_app/screens/questions_screen.dart';
import 'package:quiz_app/widgets/custom_elevated_buttom.dart';
import 'package:quiz_app/widgets/custom_text.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key, this.userScore, this.userName});

  final int? userScore;
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'Score Screen'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          children: [
            const SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.green,
              elevation: 1,
              child: ListTile(
                title: CustomText(text: 'User Name : $userName'),
                subtitle: CustomText(text: 'User Score : $userScore'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomElevatedButton(
              textButton: 'Again Quiz',
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionsScreen(userName: userName),
                    ));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomElevatedButton(
              textButton: 'show All User',
              onPressed: () {
                Navigator.pushNamed(context, '/history_screen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
