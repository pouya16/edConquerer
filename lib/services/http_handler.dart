import 'dart:convert';
import 'dart:developer';
import 'package:conquerer/services/response_handler.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../data/data.dart';
import '../pages/auth_pages/login_page.dart';
import '../widgets/common.dart';


Future<Response> httpGet(String url,{Map<String, String> headers = const {}}) async {
  if(headers.isEmpty){
    headers = {'Accept' : 'application/json'};
  }
  var res = await http.get(Uri.parse(url), headers: headers).timeout(const Duration(seconds: 20));
  
  // log(res.body);
  if (res.statusCode == 401) {
      nextRoute(
        const LoginPage(),
        isClearBackRoutes: true
      );
    return res;
  } else {
    return res;
  }
}

Future<Response> httpPost(String url, dynamic body,{Map<String, String> headers = const {}}) async {
  var myBody;
  if (body.runtimeType != String) {
    myBody = json.encode(body);
  } else {
    myBody = body;
  }

  if(headers.isEmpty){
    headers = {
      "Content-Type" : "application/json", 
      'Accept' : 'application/json',
      'Accept-Encoding' : 'gzip, deflate, br',
      'Connection' : 'keep-alive',
    };
  }

  var res = await http.post(Uri.parse(url), body: myBody, headers: headers).timeout(const Duration(seconds: 20));

  // log(res.body);

  if (res.statusCode == 401) {
      nextRoute(
        const LoginPage(),
        isClearBackRoutes: true
      );
    return res;
  } else {
    return res;
  }
}

Future<Response> httpPut(String url, dynamic body,{Map<String, String> headers = const {}}) async {
  var myBody;
  if (body.runtimeType != String) {
    myBody = json.encode(body);
  } else {
    myBody = body;
  }

  if(headers.isEmpty){
    headers = {"Content-Type" : "application/json",'Accept' : 'application/json',};
  }

  var res = await http.put(Uri.parse(url), body: myBody, headers: headers).timeout(const Duration(seconds: 20));

  // log(res.body);

  if (res.statusCode == 401) {
      nextRoute(
        LoginPage(),
        isClearBackRoutes: true
      );
    return res;
  } else {
    return res;
  }
}

Future httpMultiPart(MultipartRequest request) async {

  if(request.headers.isEmpty){
    request.headers.addAll(
      {
        'Content-Type' : 'multipart/form-data',
        'Accept' : 'application/json',
      }
    );
  }

  var response = await request.send();

  var res = response.stream.transform(utf8.decoder).join();
  var data = jsonDecode(await res);

  // print(request.fields);
  // print(data);

  if(response.statusCode == 200){
    return appResponse(isSuccess: true, data: data, message: '',statusCode: 200);
  }else{
    if(response.statusCode == 401){
        nextRoute(
          const LoginPage(),
          isClearBackRoutes: true
        );
    }else{
      return appResponse(isSuccess: false, data: data, message: data['message'], statusCode: response.statusCode);
    }
  }

}


Future httpMultipartWithToken(MultipartRequest request,{String token=''}) async {
  String _token = await AppData.getToken();

  if(token.isNotEmpty){
    _token = token;
  }

  Map<String, String> headers = {
    "Authorization": "Bearer " + _token,
    "Content-Type": 'multipart/form-data',
    'Accept' : 'application/json',
  };

  request.headers.addAll(headers);

  return httpMultiPart(request);
}

Future<Response> httpPostWithToken(dynamic url,dynamic body) async {
  String token = await AppData.getToken();

  Map<String, String> headers = {
    "Authorization": "Bearer " + token,
    "Content-Type" : "application/json", 
    'Accept' : 'application/json',
    'Accept-Encoding' : 'gzip, deflate, br',
    'Connection' : 'keep-alive',
  };

  return httpPost(url, body, headers: headers);
}

Future<Response> httpPutWithToken(dynamic url,dynamic body) async {
  String token = await AppData.getToken();

  Map<String, String> headers = {
    "Authorization": "Bearer " + token,
    "content-type": "application/json",
    "Accept" : "application/json",
  };
  

  return httpPut(url, body, headers: headers);
}

Future<Response> httpGetWithToken(dynamic url) async {
  String token = await AppData.getToken();

  Map<String, String> headers = {
    "Authorization": "Bearer " + token,
    "Accept" : "application/json",
    'Accept-Encoding' : 'gzip, deflate, br',
    'Connection' : 'keep-alive',
  };
  

  return httpGet(url, headers: headers);
}
