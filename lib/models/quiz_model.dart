class QuizModel {
  int? id;
  int? userId;
  int? priority;
  String? title;
  int? duration;
  int? score;
  int? quorum;
  String? createdAt;
  String? updatedAt;
  int? questionsCount;
  List<Questions>? questions;

  

  QuizModel(
      {this.id,
      this.userId,
      this.priority,
      this.title,
      this.duration,
      this.score,
      this.quorum,
      this.createdAt,
      this.updatedAt,
      this.questionsCount,
      this.questions});

  QuizModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    priority = json['priority'];
    title = json['title'];
    duration = json['duration'];
    score = json['score'];
    quorum = json['quorum'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionsCount = json['questions_count'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['priority'] = priority;
    data['title'] = title;
    data['duration'] = duration;
    data['score'] = score;
    data['quorum'] = quorum;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['questions_count'] = questionsCount;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class Questions {
  int? id;
  int? quizId;
  int? userId;
  String? question;
  String? type;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  List<String?>? options;
  LastStatus? lastStatus;

  List<String> answerSelected = [];
  List<String> correctAnswers = [];

  Questions(
      {this.id,
      this.quizId,
      this.userId,
      this.question,
      this.type,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.options,
      this.lastStatus});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quizId = json['quiz_id'];
    userId = json['user_id'];
    question = json['question'];
    type = json['type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    options = json['options'].cast<String?>();
    lastStatus = json['last_status'] != null
        ? LastStatus.fromJson(json['last_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quiz_id'] = quizId;
    data['user_id'] = userId;
    data['question'] = question;
    data['type'] = type;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['options'] = options;
    if (lastStatus != null) {
      data['last_status'] = lastStatus!.toJson();
    }
    return data;
  }
}

class LastStatus {
  int? id;
  String? text;
  int? statusableId;
  String? statusableType;
  String? createdAt;
  String? updatedAt;

  LastStatus(
      {this.id,
      this.text,
      this.statusableId,
      this.statusableType,
      this.createdAt,
      this.updatedAt});

  LastStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    statusableId = json['statusable_id'];
    statusableType = json['statusable_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['statusable_id'] = statusableId;
    data['statusable_type'] = statusableType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}