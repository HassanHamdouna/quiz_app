import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/custom_text.dart';

class CustomOptionCard extends StatelessWidget {
  const CustomOptionCard({
    super.key,
    required this.textOption,
    required this.colorOption,
  });
  final String textOption;
  final Color colorOption;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child:  Card(
        color: colorOption,
        elevation: 1,
        child:  ListTile(
          title:  Center(child: CustomText(text: textOption)),
        ),
      ),
    );
  }
}