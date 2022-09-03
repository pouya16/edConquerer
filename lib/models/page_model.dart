import 'dart:io';

import 'package:conquerer/models/create_lum_model.dart';
import 'package:flutter/material.dart';



class PageModel{

  File? video;
  String? videoCover;

  List<File> images = [];
  List<TextEditingController> texts = [];
  TextEditingController linkController = TextEditingController();
  FocusNode linkNode = FocusNode();

  List<CreateLumModel> question = [];
  String? points;
  Duration? duration;
  
}