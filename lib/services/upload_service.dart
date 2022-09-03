import 'dart:convert';
import 'dart:io';

import 'package:conquerer/services/base_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../data/data.dart';
import '../widgets/common.dart';

class UploadService{

  static Future upload(File file) async {

    try{
      String token = await AppData.getToken();

      var uri = Uri.parse(baseUrl + 'upload');
      var request = http.MultipartRequest('POST', uri);

      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          file.readAsBytesSync(),
          filename: file.path.split('/').last
        )
      );

      request.headers["content-type"] = "multipart/form-data";
      request.headers["Authorization"] = "Bearer $token";
      request.headers["Accept"] = "application/json";

      var response = await request.send();

      var res = response.stream.transform(utf8.decoder).join();
      var data = jsonDecode(await res);
      // print(data);
      
      if(data['status']){
        return data['data']['path'];
      }else{
        showSnackBar(data['message'], Colors.red);
        return {};
      }
    }catch(e){
      return {};
    }

  }
}