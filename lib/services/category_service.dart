import 'dart:convert';

import 'package:conquerer/data/data.dart';
import 'package:conquerer/models/category_model.dart';
import 'package:conquerer/services/response_handler.dart';

import '../widgets/common.dart';
import 'base_url.dart';
import 'http_handler.dart';

class CategoryService{


  static Future<List<CategoryModel>> getCategory(String search) async {

    String url = baseUrl + 'categories?search=$search';
    List<CategoryModel> data = [];
     
    try{

      var res = await httpGetWithToken(url);
      

      if(res.statusCode == 200){
        jsonDecode(res.body)['data'].forEach((item){
          data.add(CategoryModel.fromJson(item));
        });
        return data;
      }else{
        showError(res);
        return data;
      }
    }catch(e){
      return data;
    }

  }
  
  static Future<List<CategoryModel>> getSubCategory(int parentId) async {

    String url = baseUrl + 'categories/$parentId';
    List<CategoryModel> data = [];
     
    try{

      var res = await httpGetWithToken(url);
      // print(res.body);
      print(res.statusCode);

      if(res.statusCode == 200){
        jsonDecode(res.body)['data'].forEach((item){
          data.add(CategoryModel.fromJson(item));
        });
        return data;
      }else{
        showError(res);
        return data;
      }
    }catch(e){
      return data;
    }

  }
}