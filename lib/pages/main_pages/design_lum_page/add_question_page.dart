import 'package:conquerer/models/create_lum_model.dart';
import 'package:conquerer/provider/create_lum_provider.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:conquerer/widgets/create_lum_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../resource/colors.dart';

class AddQuestionPage extends StatefulWidget {
  AddQuestionPage({ Key? key }) : super(key: key);

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {

  List<CreateLumModel > questions = [];
  Duration duration = const Duration(minutes: 1);

  TextEditingController pointController = TextEditingController();
  FocusNode pointNode = FocusNode();


  @override
  void initState() {
    super.initState();


    if(context.read<CreateLumProvider>().pages[context.read<CreateLumProvider>().currentPage].question.isNotEmpty){
      questions = context.read<CreateLumProvider>().pages[context.read<CreateLumProvider>().currentPage].question;
    }

    if(context.read<CreateLumProvider>().pages[context.read<CreateLumProvider>().currentPage].points != null){
      pointController.text = context.read<CreateLumProvider>().pages[context.read<CreateLumProvider>().currentPage].points ?? '';
    }

    if(context.read<CreateLumProvider>().pages[context.read<CreateLumProvider>().currentPage].duration != null){
      duration = context.read<CreateLumProvider>().pages[context.read<CreateLumProvider>().currentPage].duration!;
    }

  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: AppBar(
          toolbarHeight: 70,
          shadowColor: Colors.grey[200],
          automaticallyImplyLeading: false,
          backgroundColor: blueColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          bottomOpacity: 1,
          

          title: Row(
            children:  [

              SizedBox(
                width: 30,
                child: IconButton(
                  onPressed: () => backRoute(), 
                  icon: const Icon(Icons.arrow_back_ios),
                  padding: padding(horizontal: 0),
                ),
              ),

              const Text(
                'Add a Test',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),


              const Spacer(),

              IconButton(
                onPressed: (){
                  
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(    
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (builder) {
                      return Container(
                        height: MediaQuery.of(context).copyWith().size.height / 3,
                        child: SizedBox.expand(
                          child: CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hm,
                            minuteInterval: 1,
                            secondInterval: 1,
                            initialTimerDuration: duration,
                            onTimerDurationChanged: (Duration changedtimer) {
                              duration = changedtimer;
                            },
                          ),
                        ));
                    },  // fix form
                  ).whenComplete(() {});   
                }, 
                icon: const Icon(Icons.access_time_filled_rounded,color: Colors.white,)
              ),
              
              IconButton(
                onPressed: (){

                  if(questions.isNotEmpty && pointController.text.trim().isNotEmpty){

                    context.read<CreateLumProvider>().pages[context.read<CreateLumProvider>().currentPage].question = questions;
                    context.read<CreateLumProvider>().pages[context.read<CreateLumProvider>().currentPage].duration = duration;
                    context.read<CreateLumProvider>().pages[context.read<CreateLumProvider>().currentPage].points = pointController.text.trim();
                    backRoute();
                  }

                }, 
                icon: const Icon(Icons.check,color: Colors.white,)
              ),
              
            ],
          ),
        ),

        body: SingleChildScrollView(
          padding: padding(),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              space(20),

              input(pointController, pointNode, "Points", false),

              space(20),

              ...List.generate(questions.length, (index) {
                return Container(
                  margin: padding(vertical: 5,horizontal: 0),
                  width: getSize().width,
                  padding: padding(horizontal: 8,vertical: 6),
                  child: Column(
                    children: [


                      Row(
                        children: [

                          Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),

                          space(0,width: 12),

                          Text(
                            questions[index].title.text.trim() + " :",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),

                          const Spacer(),

                          SizedBox(
                            width: 35,
                            child: TextButton(
                              onPressed: (){
                                setState(() {
                                  questions.removeAt(index);
                                });
                              }, 
                              child: Icon(Icons.remove_circle,color: Colors.grey,)
                            ),
                          )

                        ],
                      ),



                      if(questions[index].show1State)...{
                        Row(
                          children: [

                            SizedBox(
                              height: 30,
                              child: Checkbox( 
                                value: questions[index].answer1State, 
                                onChanged: (v){},
                                activeColor: Colors.green,
                              ),
                            ),

                            Text(
                              questions[index].answer1Text.text.trim(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12
                              ),
                            )
                          ],
                        ),

                      },
                      
                      if(questions[index].show2State)...{
                        Row(
                          children: [

                            SizedBox(
                              height: 20,
                              child: Checkbox(
                                
                                value: questions[index].answer2State, 
                                onChanged: (v){},
                                activeColor: Colors.green,
                              ),
                            ),

                            Text(
                              questions[index].answer2Text.text.trim(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12
                              ),
                            )
                          ],
                        ),

                      },
                      
                      if(questions[index].show3State)...{
                        Row(
                          children: [

                            SizedBox(
                              height: 30,
                              child: Checkbox(
                                
                                value: questions[index].answer3State, 
                                onChanged: (v){},
                                activeColor: Colors.green,
                              ),
                            ),

                            Text(
                              questions[index].answer3Text.text.trim(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12
                              ),
                            )
                          ],
                        ),

                      },

                      if(questions[index].show4State)...{
                        Row(
                          children: [

                            SizedBox(
                              height: 30,
                              child: Checkbox(
                                
                                value: questions[index].answer4State, 
                                onChanged: (v){},
                                activeColor: Colors.green,
                              ),
                            ),

                            Text(
                              questions[index].answer4Text.text.trim(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12
                              ),
                            )
                          ],
                        ),

                      },
                      
                      if(questions[index].show5State )...{
                        Row(
                          children: [

                            SizedBox(
                              height: 30,
                              child: Checkbox(
                                
                                value: questions[index].answer5State, 
                                onChanged: (v){},
                                activeColor: Colors.green,
                              ),
                            ),

                            Text(
                              questions[index].answer5Text.text.trim(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12
                              ),
                            )
                          ],
                        ),

                      },


                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    )
                  ),
                );
              }),


              space(15),

              dotButton(
                (){
                  
                  CreateLumWidget.questionDialog(
                    onTapSingle: (){
                      CreateLumWidget.addQuestion(false, (lum) {
                        setState(() {
                          questions.add(lum);
                        });
                      });
                    }, 
                    onTapMulti: (){
                      CreateLumWidget.addQuestion(true, (lum) {
                        setState(() {
                          questions.add(lum);
                        });
                      });

                    }
                  );

                }, 
                'Add Content'
              ),


            ],
          ),
        ),

      )
    );
  }


  dotButton(Function onTap,String text){
    return GestureDetector(
      onTap: (){
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: DottedBorder(
        color: blueColor,
        strokeWidth: 2,
        radius: const Radius.circular(5),
        dashPattern: const [4, 4],
        borderType: BorderType.RRect,
        child: Container(
          alignment: Alignment.center,
          padding: padding(horizontal: 16),
          width: getSize().width,
          height: 65,
          child: Row(      
            children: [


              const Icon(Icons.add),

              const Spacer(),
              const Spacer(),

              Text(text),

              const Spacer(),const Spacer(),const Spacer(),
              
            ],
          )
        )
      ),
    );
  }

}