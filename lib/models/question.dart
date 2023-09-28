class Question {
  late int id;
  late String word;
  late String pos;

  Question();

  Question.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    word = map['word'];
    pos = map['pos'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['word'] = word;
    map['pos'] = pos;
    return map;
  }
}
