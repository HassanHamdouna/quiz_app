import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/models/question.dart';

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
}