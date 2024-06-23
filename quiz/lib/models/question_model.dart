class QuestionModel {
  String question;
  List<String> answer;

  QuestionModel({
    required this.question,
    required this.answer,
  });

  List<String> getShuffeledAnswerList() {
    final temp = List.of(answer);
    temp.shuffle();
    return temp;
  }
}
