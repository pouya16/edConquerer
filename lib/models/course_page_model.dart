class CoursePageModel {
  int? id;
  int? userId;
  int? challengeId;
  int? priority;
  Data? data;
  String? createdAt;
  String? updatedAt;

  bool isStartQuiz = false;
  bool isFinishedQuiz = false;

  CoursePageModel(
      {this.id,
      this.userId,
      this.challengeId,
      this.priority,
      this.data,
      this.createdAt,
      this.updatedAt});

  CoursePageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    challengeId = json['challenge_id'];
    priority = json['priority'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['challenge_id'] = challengeId;
    data['priority'] = priority;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Data {
  String? link;
  String? video;
  List<String>? texts;
  List<String>? images;
  String? quizId;

  Data({this.link, this.video, this.texts, this.images, this.quizId});

  Data.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    video = json['video'];
    texts = json['texts']?.cast<String>() ?? [];
    images = json['images']?.cast<String>() ?? [];
    quizId = json['quiz_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    data['video'] = video;
    data['texts'] = texts;
    data['images'] = images;
    data['quiz_id'] = quizId;
    return data;
  }
}
