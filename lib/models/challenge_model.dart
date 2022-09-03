import 'package:conquerer/resource/colors.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';

class ChallengeModel {
  int? id;
  String? title;
  String? keyword;
  Data? data;
  String? createdAt;
  String? updatedAt;
  int? lastPage;
  int? pageCount;
  int? quizCount;
  List<int>? pages;
  List<int>? quizzes;

  ChallengeModel(
      {this.id,
      this.title,
      this.keyword,
      this.data,
      this.createdAt,
      this.updatedAt,
      this.lastPage,
      this.pageCount,
      this.quizCount,
      this.pages,
      this.quizzes});

  ChallengeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    keyword = json['keyword'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastPage = json['last_page'];
    pageCount = json['page_count'];
    quizCount = json['quiz_count'];
    try{
      pages = json['pages'].cast<int>();
      quizzes = json['quizzes'].cast<int>();
    }catch(e){}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['keyword'] = keyword;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_page'] = lastPage;
    data['page_count'] = pageCount;
    data['quiz_count'] = quizCount;
    data['pages'] = pages;
    data['quizzes'] = quizzes;
    return data;
  }
}
class Data {
  String? icon;
  String? cover;
  String? description;
  Color? color = blueColor;

  Data({this.icon, this.cover, this.description, this.color});

  Data.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    cover = json['cover'];
    description = json['description'];
    if(json['color']!=null){
      // color = Color(int.parse('0xff${json['color'].toString().replaceRange(0, 1, '')}'));
      color = HexColor(json['color']);
    }
    // color = HexColor();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = icon;
    data['cover'] = cover;
    data['description'] = description;
    // data['color'] = color;
    return data;
  }
}