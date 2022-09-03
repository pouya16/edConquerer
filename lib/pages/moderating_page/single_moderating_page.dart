import 'package:conquerer/models/vote_model.dart';
import 'package:conquerer/services/challenge_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

import '../../resource/colors.dart';




class SingleModeratingPage extends StatefulWidget {
  late VoteModel vote;
  Function changeData;

  SingleModeratingPage(this.vote,this.changeData,{ Key? key }) : super(key: key);

  @override
  _SingleModeratingPageState createState() => _SingleModeratingPageState();
}

class _SingleModeratingPageState extends State<SingleModeratingPage> {
  
  bool isShowConfirm=false;
  bool isLoading=false;

  String? state;


  TextEditingController overalExperienceController = TextEditingController();
  FocusNode overalExperienceNode = FocusNode();
  TextEditingController appliedController = TextEditingController();
  FocusNode appliedNode = FocusNode();
  TextEditingController novelityController = TextEditingController();
  FocusNode novelityNode = FocusNode();
  
  // Accept Data
  TextEditingController pointController = TextEditingController();
  FocusNode pointNode = FocusNode();
  int lumLevel = 1;

  // Rejected Data
  bool inaccurate = false;
  bool copyright = false;
  bool violent = false;
  TextEditingController describeController = TextEditingController();
  FocusNode describeNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          shadowColor: Colors.grey[200],
          backgroundColor: blueColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          bottomOpacity: 1,
          titleSpacing: 0,
          centerTitle: false,

          title: Row(
            children: const [
              
              Text(
                'Moderating',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),


              Spacer(),


              // if(isShowConfirm)...{
              //   TextButton(
              //     onPressed: (){

              //     },
              //     child: const Icon(Icons.check,color: Colors.white,size: 30,)
              //   )
              // }

            ],
          ),
        ),

        body: SingleChildScrollView(
          padding: padding(),
          child: Column(
            children: [

              space(20),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                
                  const Text(
                    'Course Name',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
            
                  Expanded(
                    child: Padding(
                      padding: padding(horizontal: 12),
                      child: const MySeparator(),
                    ),
                  ),
            
            
                  Text(
                    widget.vote.title ?? '',
                    style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
            
                ],
              ),

              space(20),

              item('Overal Experience', overalExperienceController, overalExperienceNode,isNextNode: true,next: appliedNode,rightInputText: ' / 5'),

              space(12),

              item('Applied/Abstract', appliedController, appliedNode,isNextNode: true,next: novelityNode,rightInputText: ' / 5'),
              
              space(12),

              item('Novelity', novelityController, novelityNode, rightInputText: ' / 5'),

              


              if(state == 'approved')...{
                space(30),

                item("Point's user declared", TextEditingController(), FocusNode(), rightInputText: widget.vote.data?.needPoints ?? '',isShowInput: false),

                space(12),

                item("Point's by you", pointController, pointNode, rightInputText: '',inputWidth: 80),

                space(12),

                // Level
                Row(
                  children: [

                    const Text(
                      "Luma's Difficulty",
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
              
                    Expanded(
                      child: Padding(
                        padding: padding(horizontal: 12),
                        child: const MySeparator(),
                      ),
                    ),

                    Row(
                      children: [
                        
                        // 1
                        SizedBox(
                          width: 30,
                          child: Column(
                            children: [

                              const Text(
                                "1" ,
                                style: TextStyle(
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),

                              Radio(
                                value: 1, 
                                groupValue: lumLevel, 
                                onChanged: (int? level){
                                  setState(() {
                                    lumLevel = level!;
                                  });
                                }
                              ),
                            ],
                          ),
                        ),
                        
                        // 2
                        SizedBox(
                          width: 30,
                          child: Column(
                            children: [

                              const Text(
                                "2" ,
                                style: TextStyle(
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),

                              Radio(
                                value: 2, 
                                groupValue: lumLevel, 
                                onChanged: (int? level){
                                  setState(() {
                                    lumLevel = level!;
                                  });
                                }
                              ),
                            ],
                          ),
                        ),
                        
                        // 3
                        SizedBox(
                          width: 30,
                          child: Column(
                            children: [

                              const Text(
                                "3" ,
                                style: TextStyle(
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),

                              Radio(
                                value: 3, 
                                groupValue: lumLevel, 
                                onChanged: (int? level){
                                  setState(() {
                                    lumLevel = level!;
                                  });
                                }
                              ),
                            ],
                          ),
                        ),
                        
                        // 4
                        SizedBox(
                          width: 30,
                          child: Column(
                            children: [

                              const Text(
                                "4" ,
                                style: TextStyle(
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),

                              Radio(
                                value: 4, 
                                groupValue: lumLevel, 
                                onChanged: (int? level){
                                  setState(() {
                                    lumLevel = level!;
                                  });
                                }
                              ),
                            ],
                          ),
                        ),

                        // 5
                        SizedBox(
                          width: 30,
                          child: Column(
                            children: [

                              const Text(
                                "5" ,
                                style: TextStyle(
                                  fontSize: 8,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),

                              Radio(
                                value: 5, 
                                groupValue: lumLevel, 
                                onChanged: (int? level){
                                  setState(() {
                                    lumLevel = level!;
                                  });
                                }
                              ),
                            ],
                          ),
                        ),



                      ],
                    )
                  ],
                ),

              },

              if(state == 'rejected')...{
                space(20),

                titleBox('Inaccurate', inaccurate, (newState) {
                  setState(() {
                    inaccurate = newState;
                  });
                }),
                
                space(12),

                titleBox('Copyright Issue', copyright, (newState) {
                  setState(() {
                    copyright = newState;
                  });
                }),
                
                space(12),

                titleBox('Violent/Nudity', violent, (newState) {
                  setState(() {
                    violent = newState;
                  });
                }),


                space(12),

                Row(
                  children: [
                    const Text(
                      'describe',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),


                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: padding(horizontal: 12),
                        child: const MySeparator(),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: input(describeController, describeNode, '', false)
                    )
              


                  ],
                )
              },

              space(20),

              if(state == null)...{

                isLoading
              ? loading(blueColor)
              : Padding(
                  padding: padding(),
                  child: Row(
                    children: [

                      Expanded(
                        child: button(
                          onTap: () async {
                            
                            setState(() {
                              state = 'rejected';
                              isShowConfirm = true;
                            });

                          }, 
                          text: 'Reject', 
                          bgColor: Colors.transparent ,
                          textColor: Colors.red,
                          borderColor: Colors.red,
                          radius: 50,
                          height: 40,
                          fontSize: 14
                        )
                      ),

                      space(0,width: 40),

                      Expanded(
                        child: button(
                          onTap: () async {

                            setState(() {
                              state = 'approved';
                              isShowConfirm = true;
                            });
                            
                            
                          }, 
                          text: 'Accept', 
                          bgColor: blueColor ,
                          textColor: Colors.white,
                          radius: 50,
                          height: 40,
                          fontSize: 14
                        )
                      ),


                    ],
                  ),
                ),
              
              }else ...{
                button(
                  onTap: () async {
                    
                    setState(() {
                      isLoading = true;
                    });

                    bool res = await ChallengeService.setVote(
                      widget.vote.id!, state!, describeController.text, overalExperienceController.text,
                      appliedController.text, novelityController.text, 
                      lumLevel.toString(), pointController.text, inaccurate ? '1' : '0', copyright? '1' : '0', violent? '1' : '0'
                    );

                    if(res){
                      navigatorKey.currentState!.pop(true);
                    }
                    
                    setState(() {
                      isLoading = false;
                    });

                  }, 
                  text: state == 'rejected' ? 'Add Report' : 'Send', 
                  bgColor:  state == 'rejected' ? Colors.white : blueColor, 
                  textColor:  state == 'rejected' ? Colors.red : Colors.white,
                  borderColor:  state == 'rejected' ? Colors.red : blueColor,
                  radius: 50,
                  fontSize: 16,
                  isLoading: isLoading
                ),
              },

              space(20),

            
        
            ],
          ),
        ),

      )
    );
  }




  Widget item(String title,TextEditingController inputController,FocusNode inputNode,{bool isNextNode=false,FocusNode? next,String? rightInputText,int inputWidth=50,bool isShowInput=true}){
    return Row(
      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
  
        Expanded(
          child: Padding(
            padding: padding(horizontal: 12),
            child: const MySeparator(),
          ),
        ),
  
  
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            if(isShowInput)...{
              SizedBox(
                width: inputWidth.toDouble(),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: inputController,
                  focusNode: inputNode,

                  onFieldSubmitted: (v){
                    if(isNextNode){
                      next?.requestFocus();
                    }
                  },
                  
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    // height: 1
                  ),

                  decoration: InputDecoration(
                    border: InputBorder.none,

                    focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius(5),
                      gapPadding: 6,
                      borderSide: const BorderSide(
                        width: 1
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius(5),
                      gapPadding: 6,
                      borderSide: const BorderSide(
                        width: 1
                      ),
                    ),
                  ),
                ),
              ),

            },

            if(rightInputText != null)...{
              
              space(0,width: 6),

              Text(
                rightInputText,
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            }

          ],
        ),

      ],
    );
  }

  Widget titleBox(String title,bool state,Function(bool newSatet) onChange){
    return Row(
      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
  
        Expanded(
          child: Padding(
            padding: padding(horizontal: 12),
            child: const MySeparator(),
          ),
        ),
  
  
        Checkbox(value: state, onChanged: (v) => onChange(v!))
      ],
    ); 
  }
}