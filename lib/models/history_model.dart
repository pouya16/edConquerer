import 'challenge_model.dart';

class HistoryModel {
  int? id;
  String? title;
  String? keyword;
  Data? data;
  int? pageCount;
  int? quizCount;
  int? lastPage;
  String? progress;
  int? time;

  HistoryModel(
      {this.id,
      this.title,
      this.keyword,
      this.data,
      this.pageCount,
      this.quizCount,
      this.lastPage,
      this.progress,
      this.time});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    keyword = json['keyword'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    pageCount = json['page_count'];
    quizCount = json['quiz_count'];
    lastPage = json['last_page'];
    progress = json['progress'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['keyword'] = keyword;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['page_count'] = pageCount;
    data['quiz_count'] = quizCount;
    data['last_page'] = lastPage;
    data['progress'] = progress;
    data['time'] = time;
    return data;
  }
}
