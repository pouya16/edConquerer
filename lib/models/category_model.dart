import 'dart:ui';

import 'package:conquerer/resource/colors.dart';

class CategoryModel {
  int? id;
  int? parentId;
  int? priority;
  int? points;
  String? title;
  Data? data = Data();
  String? createdAt;
  String? updatedAt;

  

  CategoryModel(
      {this.id,
      this.parentId,
      this.priority,
      this.title,
      this.data,
      this.createdAt,
      this.updatedAt});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    priority = json['priority'];
    points = json['points'];
    title = json['title'];
    if(json['data'] != null){
      data = Data.fromJson(json['data']);
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['priority'] = priority;
    data['title'] = title;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Data {
  Color color = blueColor;
  String? mainColor;
  String? logo;

  Data({this.mainColor, this.logo});

  Data.fromJson(Map<String, dynamic> json) {
    if(json['main_color'] != null){
      color = Color(int.parse(json['main_color'].substring(1, 7), radix: 16) + 0xFF000000);
    }
    mainColor = json['main_color'];
    logo = json['logo'] ?? json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    
    data['main_color'] = mainColor;
    data['logo'] = logo;
    return data;
  }
}