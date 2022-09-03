import 'dart:async';

import 'package:conquerer/models/challenge_model.dart';
import 'package:conquerer/models/course_page_model.dart';
import 'package:conquerer/models/quiz_model.dart';
import 'package:conquerer/resource/colors.dart';
import 'package:conquerer/services/challenge_service.dart';
import 'package:flutter/material.dart';

import '../../../widgets/common.dart';

class StartQuizPage extends StatefulWidget {
  ChallengeModel challenge;
  CoursePageModel page;



  StartQuizPage(this.challenge,this.page,{Key? key }) : super(key: key);

  @override
  _StartQuizPageState createState() => _StartQuizPageState();
}

class _StartQuizPageState extends State<StartQuizPage> {

  bool isFinished = false;
  bool isLoading = true;
  bool isLoadingFinish = false;

  QuizModel? quizData;

  late Timer timer;
  Duration? duration;


  
  @override
  void initState() {
    super.initState();

    getData();
  }


  getData() async {

    setState(() {
      isLoading = true;
    });

    quizData = await ChallengeService.startQuiz(widget.page.data!.quizId!);

    if(quizData != null){
      duration = Duration(minutes: quizData?.duration ?? 0);
      startTimer();
    }

    setState(() {
      isLoading = false;
    });
  }

  startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if(t.isActive){
        if((duration?.inSeconds ?? -1) > 0){
          duration = Duration(seconds: ((duration?.inSeconds ?? 0) - 1));
          setState(() {});
        }

        if((duration?.inSeconds ?? 0) <= 0){
          t.cancel();
          onTap();
        }
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        navigatorKey.currentState!.pop(isFinished);
        return false;
      },
      child: Scaffold(
        
        appBar: AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          shadowColor: Colors.grey[200],
          backgroundColor: blueColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          bottomOpacity: 1,
          titleSpacing: 12 ,
    
          title: Row(
            children: [
    
              IconButton(onPressed: ()=>  backRoute(), icon:const Icon( Icons.arrow_back_ios_new, color: Colors.white,)),
    
              Text(
                widget.challenge.title ?? '',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
    
              const Spacer(),
    
              if(duration != null)...{
                Text(
                  '${duration!.inMinutes.remainder(60).toString()}:${duration!.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                )
              }
              
    
            ],
          ),
        ),

        body: isLoading 
      ? loading(blueColor)
      : SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
            padding: padding(),
            child: Column(
              children: [
      
                space(20,width: getSize().width),
      
                ...List.generate(quizData?.questions?.length ?? 0, (index) {
                  return Container(
                    margin: padding(vertical: 20,horizontal: 0),
                    width: getSize().width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        space(0,width: getSize().width),
      
                        Text(
                          "● " + (quizData?.questions?[index].question ?? ''),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
      
      
                        ...List.generate(quizData?.questions?[index].options?.length ?? 0, (i){
                          
                          return quizData?.questions?[index].options![i] != null
                          ? SizedBox(
                            height: 45,
                            child: CheckboxListTile(
                              selectedTileColor: Colors.red,
                              
                              activeColor: isFinished
                                ? checkCorrect(quizData?.questions?[index].options?[i] ?? '', index)
                                    ? Colors.green
                                    : Colors.red
                                : blueColor,
                              
                              value: quizData?.questions?[index].answerSelected.contains(quizData?.questions?[index].options?[i]) ?? false, 
                              
                              onChanged: (bool? value){
      
                                if(!isFinished){
      
                                  if(quizData?.questions?[index].answerSelected.contains(quizData?.questions?[index].options?[i]) ?? true){
                                    quizData?.questions?[index].answerSelected.remove(
                                      quizData?.questions?[index].options?[i]
                                    );
                                  }else{
                                    quizData?.questions?[index].answerSelected.add(
                                      quizData?.questions?[index].options?[i] ?? ''
                                    );
                                  }
      
                                }
      
                                setState(() {
                                  
                                });
                              },
                              title: Text(
                                quizData?.questions?[index].options?[i] ?? '',
                                
                              ),
                              contentPadding: padding(horizontal: 0),
                              dense: true,
                            ),
                          )
                          : const SizedBox();
                        }),
      
                        
                      ],
                    ),
                  );
                }),
      
                space(20),

                if(quizData != null)...{
                  if(!isFinished)...{
                    button(
                      onTap: () async {
                        onTap();
                      }, 
                      text: 'Finish', 
                      bgColor: Colors.green, 
                      textColor: Colors.white,
                      isLoading: isLoadingFinish
                    ),
                  },
        
                },
                
                if(isFinished)...{
                  
                  space(10),
      
                  button(
                    onTap: (){
                      navigatorKey.currentState!.pop(true);
                    }, 
                    text: 'Back', 
                    bgColor: blueColor, 
                    textColor: Colors.white
                  ),
                },
      
                space(40),
      
              ],
            ),
          ),
      ),
      ),
    );
  }

  onTap() async {
    setState(() {
      isLoadingFinish = true;
    });

    
    List res = await ChallengeService.finishQuiz(widget.page.data!.quizId!, quizData!);

    if(res.isNotEmpty){
      for (var i = 0; i < res.length; i++) {
        quizData!.questions![i].correctAnswers = res[i]['correct'].cast<String>();
      }

      isFinished = true;
    }
    
    setState(() {
      isLoadingFinish = false;
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  bool checkCorrect(String text,int index){    
    return quizData?.questions?[index].correctAnswers.contains(text) ?? false;
  }
  
}

