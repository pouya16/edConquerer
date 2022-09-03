import 'dart:convert';
import 'dart:developer';
import 'package:conquerer/services/base_url.dart';
import 'package:conquerer/services/response_handler.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:persian_number_utility/persian_number_utility.dart';
import '../data/data.dart';
import 'http_handler.dart';


class AuthService{


  static Future accountVerification(String code,String email) async {

    String url = baseUrl + 'verify/$email';
    
    try{
      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields['code'] = code.toEnglishDigit();

      AppResponseModel res = await httpMultiPart(request);

      if(res.isSuccess){
      
        return true;
      }else{
        showSnackBar(res.message, Colors.red);
        return false;
      }
    
    }catch(e){
      return false;
    }

    // print('object');

    // var headers = {
    //   'Accept': 'application/json'
    // };
    // var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}verify/$email'));
    // request.fields.addAll({
    //   'code': code
    // });

    // request.headers.addAll(headers);

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   return true;
    // }else {
    //   print(response.reasonPhrase);
    //   return false;
    // }



  }
  
  static Future resend(String username) async {

    String url = baseUrl + 'resend/$username';
    
    try{

      var res = await httpGet(url);

      if(res.statusCode == 200){
        return true;
      }else{
        showSnackBar(jsonDecode(res.body)['message'].toString(), Colors.red);
        return false;
      }
    
    }catch(e){
      return false;
    }

  }

  static Future forget(String username) async {

    String url = baseUrl + 'forget/$username';
    
    try{

      var res = await httpPut(url,{});

      if(res.statusCode == 200){
        return true;
      }else{
        showSnackBar(jsonDecode(res.body)['message'].toString(), Colors.red);
        return false;
      }
    
    }catch(e){
      return false;
    }

  }

  static Future me() async {

    String url = baseUrl + 'me';
    
    try{

      var res = await httpGetWithToken(url);

      if(res.statusCode == 200){
        return jsonDecode(res.body)['data'];
      }else{
        showSnackBar(jsonDecode(res.body)['message'].toString(), Colors.red);
        return null;
      }
    
    }catch(e){
      return null;
    }

  }
  
  static Future login(String username,String password) async {

    String url = baseUrl + 'login';
    
    try{
      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields['email'] = username.toEnglishDigit();
      request.fields['password'] = password.toEnglishDigit();

      AppResponseModel res = await httpMultiPart(request);

      if(res.isSuccess){
        await AppData.saveName(res.data['data']['user']['name']);
        await AppData.saveToken(res.data['data']['token']);
        return true;
      }else{
        showSnackBar(res.message, Colors.red);
        return false;
      }
    
    }catch(e){
      return false;
    }

  }
  
  static Future register(String username,String password) async {

    String url = baseUrl + 'register';
    
    try{

      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields['name'] = 'name';
      request.fields['family'] = 'family';
      request.fields['is_real'] = '0';
      request.fields['email'] = username.toEnglishDigit();
      request.fields['password'] = password.toEnglishDigit();

      AppResponseModel res = await httpMultiPart(request);

      if(res.isSuccess){
        await AppData.saveName(res.data['data']['user']['name']);
        await AppData.saveToken(res.data['data']['token']);
        return true;
      }else{
        showErrorMultipart(res);
        return false;
      }
    }catch(e){
      return false;
    }

  }

  // static Future selectPassword(String pass1,String pass2,String token) async {

  //   String url = baseUrl + 'Auth/SelectPassword';
    
  //   try{

  //     var request = http.MultipartRequest("POST", Uri.parse(url));

  //     request.fields['Password'] = pass1.toEnglishDigit();
  //     request.fields['ConfirmPassword'] = pass2.toEnglishDigit();

  //     AppResponseModel res = await httpMultipartWithToken(request,token: token);

  //     try{
  //       await AppData.saveToken(res.data['access_token']);
  //     }catch(e){}
    
  //     return res;
  //   }catch(e){
  //     return appResponse(isSuccess: false, data: null, message: notConnectedToServerError, statusCode: -1);
  //   }

  // }
  
  // static Future forgetPassword(String username,String autoCode) async {

  //   String url = baseUrl + 'Auth/ForgotPassword';
    
  //   try{

  //     var request = http.MultipartRequest("POST", Uri.parse(url));

  //     request.fields['UserName'] = username.toEnglishDigit();
  //     // request.fields['auto_code'] = autoCode;

  //     AppResponseModel res = await httpMultiPart(request);
    
  //     return res;
  //   }catch(e){
  //     return appResponse(isSuccess: false, data: null, message: notConnectedToServerError, statusCode: -1);
  //   }

  // }
  
  // static Future changePassword(String username,String verificationCode,String password, String confirmPassword) async {

  //   String url = baseUrl + 'Auth/ChangePassword';
    
  //   try{

  //     var request = http.MultipartRequest("POST", Uri.parse(url));

  //     request.fields['UserName'] = username.toEnglishDigit();
  //     request.fields['VerificationCode'] = verificationCode.toEnglishDigit();
  //     request.fields['Password'] = password.toEnglishDigit();
  //     request.fields['ConfirmPassword'] = confirmPassword.toEnglishDigit();

  //     AppResponseModel res = await httpMultiPart(request);
    
  //     return res;
  //   }catch(e){
  //     return appResponse(isSuccess: false, data: null, message: notConnectedToServerError, statusCode: -1);
  //   }

  // }

  

}