class FinalAnswerModel {
  String? question;
  List<String>? answer;
  List<String>? correct;
  bool? isCorrect;

  FinalAnswerModel({this.question, this.answer, this.correct, this.isCorrect});

  FinalAnswerModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'].cast<String>();
    correct = json['correct'].cast<String>();
    isCorrect = json['is_correct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    data['correct'] = correct;
    data['is_correct'] = isCorrect;
    return data;
  }
}