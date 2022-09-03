import 'package:flutter/material.dart';

class CreateLumModel{

  bool isMultiAnswer;
  TextEditingController title = TextEditingController();
  FocusNode nodeTitle = FocusNode();

  TextEditingController answer1Text = TextEditingController();
  TextEditingController answer2Text = TextEditingController();
  TextEditingController answer3Text = TextEditingController();
  TextEditingController answer4Text = TextEditingController();
  TextEditingController answer5Text = TextEditingController();

  FocusNode node1 = FocusNode();
  FocusNode node2 = FocusNode();
  FocusNode node3 = FocusNode();
  FocusNode node4 = FocusNode();
  FocusNode node5 = FocusNode();

  bool answer1State = false;
  bool answer2State = false;
  bool answer3State = false;
  bool answer4State = false;
  bool answer5State = false;
  
  // true --> show input | false --> not show input
  bool show1State = true;
  bool show2State = true;
  bool show3State = true;
  bool show4State = true;
  bool show5State = true;


  CreateLumModel({
    required this.isMultiAnswer,
  });



  bool isShowAddButton(){
    return (!show1State || !show2State || !show3State || !show4State || !show5State);
  }


  offAllInput(){
    answer1State = false;
    answer2State = false;
    answer3State = false;
    answer4State = false;
    answer5State = false;
  }
}