import 'dart:io';
import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/custom_text.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('History Screen'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const ListTile(
            title: CustomText(text: 'firstName'),
            subtitle: CustomText(text: 'Score 100',fontSize: 12),

          );
        },
      ),
    );
  }
}