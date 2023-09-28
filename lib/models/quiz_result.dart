class QuizResult {
  late String name;
  late int score;

  QuizResult();

  QuizResult.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    score = map['score'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['name'] = name;
    map['score'] = score;
    return map;
  }
}
