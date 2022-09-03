import 'dart:convert';
import 'package:conquerer/models/country_model.dart';

import '../widgets/common.dart';
import 'base_url.dart';
import 'http_handler.dart';

class CountryService{


  static Future<List<CountryModel>> getCountry() async {

    String url = baseUrl + 'countries';
    List<CountryModel> data = [];
     
    try{

      var res = await httpGetWithToken(url);

      if(res.statusCode == 200){
        jsonDecode(res.body)['data'].forEach((item){
          data.add(CountryModel.fromJson(item));
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