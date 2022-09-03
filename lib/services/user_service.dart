import 'dart:convert';

import 'package:conquerer/models/category_model.dart';
import 'package:conquerer/models/history_model.dart';
import 'package:conquerer/resource/colors.dart';
import 'package:conquerer/services/response_handler.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';
import '../widgets/common.dart';
import 'base_url.dart';
import 'package:http/http.dart' as http;

import 'http_handler.dart';

class UserService{

  static Future update(String name,String family,String coName,String country,String voucherCode,String lastDeree,String lastDegreeTopic, bool isReal,String category,String? imagePhoto, String? degreePhoto ) async {

    String url = baseUrl + 'me';
    
    try{

      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields['_method'] = 'put';
      request.fields['name'] = name;
      request.fields['co_name'] = coName;
      request.fields['family'] = family;
      request.fields['country'] = country;
      request.fields['voucherCode'] = voucherCode;
      request.fields['is_real'] = isReal ? '1' : '0';
      request.fields['last_degree'] = lastDeree;
      request.fields['topics'] = lastDegreeTopic;
      request.fields['interest'] = category;
      
      if(imagePhoto != null){
        request.fields['profile_photo'] = imagePhoto;
      }
      if(degreePhoto != null){
        request.fields['degree_photo'] = degreePhoto;
      }

      AppResponseModel res = await httpMultipartWithToken(request);

      if(res.isSuccess){
        
        return true;
      }else{
        showErrorMultipart(res);
        return false;
      }
    }catch(e){
      return false;
    }

  }
  
  static Future<List<CategoryModel>> getFavorite() async {

    String url = baseUrl + 'me/subscribe';
    List<CategoryModel> data = [];

    String token = await AppData.getToken();

    if(token.isEmpty){
      return data;
    }
     
    try{

      var res = await httpGetWithToken(url);
      // print(res.body);
      // print(res.statusCode);

      if(res.statusCode == 200){
        jsonDecode(res.body)['data']['user_category'].forEach((item){
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
  
  static Future<List<HistoryModel>> inProgress() async {

    String url = baseUrl + 'me/challenge';
    List<HistoryModel> data = [];

    String token = await AppData.getToken();

    if(token.isEmpty){
      return data;
    }
     
    try{

      var res = await httpGetWithToken(url);
      // print(res.body);
      // print(res.statusCode);

      if(res.statusCode == 200){
        jsonDecode(res.body)['data'].forEach((item){
          data.add(HistoryModel.fromJson(item));
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
  
  static Future<bool> addToFavorite(int id) async {

    String url = baseUrl + 'me/subscribe';

    try{

      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.fields['category_id'] = '$id';

      
      AppResponseModel res = await httpMultipartWithToken(request);

      if(res.isSuccess){
        // showSnackBar(res.data['message'], Colors.green);
        return true;
      }else{
        // showErrorMultipart(res);
        return false;
      }
    }catch(e){
      return false;
    }

  }
}