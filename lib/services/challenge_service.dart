import 'dart:convert';
import 'dart:developer';
import 'package:conquerer/data/data.dart';
import 'package:conquerer/models/challenge_model.dart';
import 'package:conquerer/models/course_page_model.dart';
import 'package:conquerer/models/create_lum_model.dart';
import 'package:conquerer/models/page_model.dart';
import 'package:conquerer/models/quiz_model.dart';
import 'package:conquerer/models/vote_model.dart';
import 'package:conquerer/services/base_url.dart';
import 'package:conquerer/services/response_handler.dart';
import 'package:conquerer/services/upload_service.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../widgets/common.dart';
import 'http_handler.dart';

class ChallengeService{
  

  static Future<List<VoteModel>> getVotes() async {

    String url = baseUrl + 'vote';
    List<VoteModel> data = [];
     
    try{

      var res = await httpGetWithToken(url);
      print(res.body);
      // print(res.statusCode);

      if(res.statusCode == 200){
        jsonDecode(res.body)['data'].forEach((item){
          data.add(VoteModel.fromJson(item));
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
  
  static Future setVote(int challengeId,String vote,String desc,String overalExperience, String appliedAbstract,String novelity,String difficulty,String pointBYModerato,String inaccurate ,String copyrightIssue,String violent ) async {

    String url = baseUrl + 'vote';
     
    try{

      var request = http.MultipartRequest("POST", Uri.parse(url));
      
      request.fields['data[age]'] = '0';

      request.fields['challenge_id'] = challengeId.toString();
      request.fields['vote'] = vote;
      request.fields['description'] = desc.isEmpty ? "description" : desc;
      request.fields['overal_experience'] = overalExperience;
      request.fields['applied_abstract'] = appliedAbstract;
      request.fields['novelity'] = novelity;
      request.fields['Difficulty'] = difficulty;
      request.fields['point_by_moderato'] = pointBYModerato;
      request.fields['inaccurate'] = inaccurate;
      request.fields['copyright_issue'] = copyrightIssue;
      request.fields['violont_nudity'] = violent;


      AppResponseModel res = await httpMultipartWithToken(request);
      // print(res.statusCode);
      // print(res.message);

      if(res.statusCode == 200){
        return true;
      }else{
        showErrorMultipart(res);
        return false;
      }
    }catch(e){
      return false;
    }

  }
  


  static Future<List<ChallengeModel>> getChallege(int id,String search) async {

    String url = baseUrl + 'categories/$id/challenges?search=$search';
    List<ChallengeModel> data = [];
     
    try{

      var res = await httpGetWithToken(url);
      // print(res.body);
      // print(res.statusCode);

      if(res.statusCode == 200){
        jsonDecode(res.body).forEach((item){
          data.add(ChallengeModel.fromJson(item));
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
  
  static Future<bool> updateVotes(String state,int challengeId) async {

    String url = baseUrl + 'challenge';
     
    try{

      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields['_method'] = 'put';
      request.fields['challenge_id'] = challengeId.toString();
      request.fields['vote'] = state.toString();

      AppResponseModel res = await httpMultiPart(request);

      if(res.statusCode == 200){
        return true;
      }else{
        showErrorMultipart(res);
        return false;
      }
    }catch(e){
      return false;
    }

  }
  
  
  static Future getChallengeDetails(int challengeId) async {

    String url = baseUrl + 'play/challenge/$challengeId';
     
    try{

      var res = await httpGetWithToken(url);

      if(res.statusCode == 200){
        return ChallengeModel.fromJson(jsonDecode(res.body)['data']);
      }else{
        showError(res);
        return null;
      }
    }catch(e){
      return null;
    }

  }
  
  static Future getFullPageData(int challengeId,int pageId) async {

    String url = baseUrl + 'play/challenge/$challengeId/page/$pageId';
     
    try{

      var res = await httpGetWithToken(url);

      if(res.statusCode == 200){
        return CoursePageModel.fromJson(jsonDecode(res.body)['data']);
      }else{
        // showError(res);
        return null;
      }
    }catch(e){
      return null;
    }

  }
  

  static Future startQuiz(String quizId) async {

    String url = baseUrl + 'quiz/play/$quizId';
    

    try{

      var res = await httpGetWithToken(url);

      print(jsonDecode(res.body)['data']);

      if(res.statusCode == 200){
        return QuizModel.fromJson(jsonDecode(res.body)['data']);
      }else{
        showError(res);
        return null;
      }
    }catch(e){
      return null;
    }

  }
  
  static Future finishQuiz(String quizId, QuizModel quizModel) async {

    String url = baseUrl + 'quiz/play/$quizId';
     
    try{
      var map = <String, dynamic>{};

      for (var item in quizModel.questions!) {
        map['answers[${item.id}][]'] = item.answerSelected;
      }
      

      FormData formData = FormData.fromMap(map);

      final dio = Dio();
      String token = await AppData.getToken();

      dio.options.headers = {
        "Authorization": "Bearer " + token,
        "Accept" : "application/json",
        'Accept-Encoding' : 'gzip, deflate, br',
        'Connection' : 'keep-alive',
      };

      final responseJson = await dio.post(
        url,
        data: formData,
      );
      // print('responseJson');
      // print(responseJson);
      // print(responseJson.statusCode);

      if(responseJson.statusCode == 200){
        return responseJson.data['data'];
      }else{
        showErrorMultipart(AppResponseModel(isSuccess: false, data: null, message: responseJson.data['message']));
        return [];
      }
    }catch(e){
      print(e);
      return [];
    }

  }
  
  static Future createChallenge(int catId,String cover,String icon,String color,String title,String desc) async {

    String url = baseUrl + 'challenge';
     
    try{

      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields['category_id'] = catId.toString();
      request.fields['keyword'] = 'keyword';
      request.fields['title'] = title;
      request.fields['data[icon]'] = icon;
      request.fields['data[need_points]'] = '0';
      request.fields['data[cover]'] = cover;
      request.fields['data[description]'] = desc;
      request.fields['data[color]'] = color;

      AppResponseModel res = await httpMultipartWithToken(request);

      if(res.statusCode == 200){
        return res.data['data']['id'];
      }else{
        showErrorMultipart(res);
        return null;
      }
    }catch(e){
      return null;
    }

  }

  static Future createPage(int challengId,PageModel page) async {

    String url = baseUrl + 'page';
     
    try{
      
      List<String> imageNames = [];
      if(page.images.isNotEmpty){
        for (var item in page.images) {
          imageNames.add(await UploadService.upload(item));
        }
      }

      FormData formData = FormData.fromMap({
        'challenge_id' : challengId.toString(),
        'data[link]' : page.linkController.text.trim(),
      
        if(page.video != null)...{
          'data[video]' : await UploadService.upload(page.video!),
        },

        'data[texts][]' : [
          ...List.generate(page.texts.length, (index) {
            return page.texts[index].text.trim();
          })
        ],

        'data[images][]' : [
          ...List.generate(imageNames.length, (index) {
            return imageNames[index];
          })
        ]
        
      });



      
      if(page.question.isNotEmpty){
        int? quizId = await createQuiz(challengId, page);

        for (var question in page.question) {
          bool? res = await createQuestion(quizId!, question); 
        }

        formData.fields.addAll({MapEntry('data[quiz_id]' , quizId.toString())});
      }

      print(formData.fields);
      print('-------------');

      final dio = Dio();
      String token = await AppData.getToken();

      dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',  
        "Authorization": "Bearer " + token
      };

      final responseJson = await dio.post(
        url,
        data: formData,
      );

      if(responseJson.statusCode == 200){
        print('created page ${responseJson.data['data']['id'] }');
        return true;
      }else{
        showErrorMultipart(AppResponseModel(isSuccess: false, data: null, message: responseJson.data['message']));
        return false;
      }
    }catch(e){
      return false;
    }

  }

  static Future createQuiz(int challengId,PageModel page) async {

    String url = baseUrl + 'quiz';
     
    try{

      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.fields['challenge_id'] = challengId.toString();
      request.fields['duration'] = page.duration?.inMinutes.toString() ?? '0';
      request.fields['score'] = page.points ?? '0';

      request.fields['title'] = 'title';
      request.fields['quorum'] = '0';

      AppResponseModel res = await httpMultipartWithToken(request);

      if(res.statusCode == 200){
        print('created quiz');
        return res.data['data']['id'];
      }else{
        showErrorMultipart(res);
        return null;
      }
    }catch(e){
      return null;
    }

  }

  static Future createQuestion(int quizId,CreateLumModel question) async {

    String url = baseUrl + 'question';
     
    try{


      FormData formData = FormData.fromMap({
        'quiz_id' : quizId.toString(),
        'question' : question.title.text.trim(),
        'type' : 'string',
        'data[option][]' : [
          question.answer1Text.text.trim(),
          question.answer2Text.text.trim(),
          question.answer3Text.text.trim(),
          question.answer4Text.text.trim(),
          question.answer5Text.text.trim(),
        ],

        'data[answer][]' : [
          if(question.show1State && question.answer1State)...{
            question.answer1Text.text.trim(),
          },

          if(question.show2State && question.answer2State)...{
            question.answer2Text.text.trim(),
          },

          if(question.show3State && question.answer3State)...{
            question.answer3Text.text.trim(),
          },

          if(question.show4State && question.answer4State)...{
            question.answer4Text.text.trim(),
          },

          if(question.show5State && question.answer5State)...{
            question.answer5Text.text.trim()
          }
        ]
      });



      final dio = Dio();
      String token = await AppData.getToken();

      dio.options.headers = {
        'Accept': 'application/json',
        'Content-Type': 'multipart/form-data',  
        "Authorization": "Bearer " + token
      };

      final responseJson = await dio.post(
        url,
        data: formData,
      );

      if(responseJson.statusCode == 200){
        print('created question ${responseJson.data['data']['id'] }');
        return true;
      }else{
        showErrorMultipart(AppResponseModel(isSuccess: false, data: null, message: responseJson.data['message']));
        return false;
      }
    }catch(e){
      return false;
    }

  }





}