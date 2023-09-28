import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz_result.dart';

class FbStoreController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Question>> read() async* {
    yield* _firestore
        .collection('Questions').orderBy('word')
        .withConverter<Question>(
      fromFirestore: (snapshot, options) => Question.fromMap(snapshot.data()!),
      toFirestore: (Question value, options) => value.toMap(),
    )
        .snapshots();
  }


  Stream<QuerySnapshot<QuizResult>> readQuizResult() async* {
    yield* _firestore
        .collection('QuizResults').orderBy('score')
        .withConverter<QuizResult>(
      fromFirestore: (snapshot, options) => QuizResult.fromMap(snapshot.data()!),
      toFirestore: (QuizResult value, options) => value.toMap(),
    )
        .snapshots();
  }


}