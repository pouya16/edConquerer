class VoteModel {
  int? id;
  int? userId;
  int? categoryId;
  String? title;
  String? keyword;
  Data? data;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? pagesCount;
  int? quizzesCount;
  LastStatus? lastStatus;

  VoteModel(
      {this.id,
      this.userId,
      this.categoryId,
      this.title,
      this.keyword,
      this.data,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.pagesCount,
      this.quizzesCount,
      this.lastStatus});

  VoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    title = json['title'];
    keyword = json['keyword'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pagesCount = json['pages_count'];
    quizzesCount = json['quizzes_count'];
    lastStatus = json['last_status'] != null
        ? LastStatus.fromJson(json['last_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['keyword'] = keyword;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pages_count'] = pagesCount;
    data['quizzes_count'] = quizzesCount;
    if (lastStatus != null) {
      data['last_status'] = lastStatus!.toJson();
    }
    return data;
  }
}

class Data {
  String? price;
  String? needPoints;
  String? givenPoints;
  String? difficulty;
  String? accuracy;
  String? appliedAbstract;
  String? targetAge;
  String? pathPercentage;

  Data(
      {this.price,
      this.needPoints,
      this.givenPoints,
      this.difficulty,
      this.accuracy,
      this.appliedAbstract,
      this.targetAge,
      this.pathPercentage});

  Data.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    needPoints = json['need_points'];
    givenPoints = json['given_points'];
    difficulty = json['difficulty'];
    accuracy = json['accuracy'];
    appliedAbstract = json['applied_abstract'];
    targetAge = json['target_age'];
    pathPercentage = json['path_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['need_points'] = needPoints;
    data['given_points'] = givenPoints;
    data['difficulty'] = difficulty;
    data['accuracy'] = accuracy;
    data['applied_abstract'] = appliedAbstract;
    data['target_age'] = targetAge;
    data['path_percentage'] = pathPercentage;
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