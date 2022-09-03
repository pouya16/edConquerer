import 'dart:io';

import 'package:conquerer/models/create_lum_model.dart';
import 'package:flutter/material.dart';

import '../models/page_model.dart';

class CreateLumProvider extends ChangeNotifier{


  late int challengeId;

  

  List<PageModel> pages = [PageModel()];
  int currentPage=0;
  


  

  clear(){
    pages = [PageModel()];
    currentPage = 0;


    notifyListeners();
  }
  
}