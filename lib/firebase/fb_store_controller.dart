import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/models/fb_response.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz_result.dart';
import 'package:quiz_app/utils/firebase_helper.dart';

class FbStoreController with FirebaseHelper{
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

  Future<FbResponse> createQuizResult(QuizResult quizResult) async {
    return _firestore
        .collection('QuizResults')
        .add(quizResult.toMap())
        .then((value) => successfullyResponse)
        .catchError((error) => errorResponse);
  }


}