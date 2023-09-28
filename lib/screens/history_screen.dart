import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/firebase/fb_store_controller.dart';
import 'package:quiz_app/models/quiz_result.dart';
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
      body: StreamBuilder<QuerySnapshot<QuizResult>>(
        stream: FbStoreController().readQuizResult(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: CustomText(text: 'No Data'),
              );
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.black54,
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListTile(
                      title: CustomText(
                          colorText: Colors.white,
                          text:
                              'Name: ${getQuizResult(snapshot.data!.docs[index]).name}'),
                      subtitle: CustomText(
                          colorText: Colors.white,
                          text:
                              'Score ${getQuizResult(snapshot.data!.docs[index]).score} / 50',
                          fontSize: 12),
                    ),
                  );
                },
              );

            case ConnectionState.done:
              return const CustomText(text: 'No Data');
          }
        },
      ),
    );
  }

  QuizResult getQuizResult(QueryDocumentSnapshot<QuizResult> result) {
    QuizResult quizResult = QuizResult();
    quizResult.name = result.data().name;
    quizResult.score = result.data().score;
    return quizResult;
  }
}
