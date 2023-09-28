import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key,this.userScore});
  final int? userScore;
  @override
  Widget build(BuildContext context) {
    print('userScore :: ${userScore}');
    return const Scaffold(
    );
  }
}
