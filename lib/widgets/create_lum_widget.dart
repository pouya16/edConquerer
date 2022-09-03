
import 'package:conquerer/models/create_lum_model.dart';
import 'package:conquerer/provider/create_lum_provider.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resource/colors.dart';

class CreateLumWidget{


  static componentDialog({required Function onTapVideo,required Function onTapPhoto,required Function onTapText,required Function onTapQuestion,}){
    showDialog(
      context: navigatorKey.currentContext!, 
      barrierColor: Colors.white.withOpacity(.6),
      builder: (_){
        return Dialog(
          insetPadding: padding(horizontal: 20),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: padding(),
            width: getSize().width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                space(16),

                const Text(
                  'Add Component:',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 14
                  ),
                ),

                space(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapVideo();
                      },
                      child: Container(
                        width: 53,
                        height: 53,
                        alignment: Alignment.center,

                        child: const Icon(
                          Icons.video_call_rounded,
                          color: Colors.white,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: borderRadius(25)
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapPhoto();
                      },
                      child: Container(
                        width: 53,
                        height: 53,
                        alignment: Alignment.center,

                        child: const Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),

                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: borderRadius(25)
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapText();
                      },
                      child: Container(
                        width: 53,
                        height: 53,
                        alignment: Alignment.center,

                        child: const Text(
                          'T',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: borderRadius(25)
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapQuestion();
                      },
                      child: Container(
                        width: 53,
                        height: 53,
                        alignment: Alignment.center,

                        child: const Text(
                          '?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: borderRadius(25)
                        ),
                      ),
                    ),

                  ],
                ),

                space(20),

              ],
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54,width: 1),
              borderRadius: borderRadius(25)
            ),
          ),
        );
      }
    ); 
  }


  static videoDialog({required Function onTapCamera,required Function onTapGallery}){
    showDialog(
      context: navigatorKey.currentContext!, 
      barrierColor: Colors.white.withOpacity(.6),
      builder: (_){
        return Dialog(
          insetPadding: padding(horizontal: 20),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: padding(),
            width: getSize().width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                space(16),

                const Text(
                  'Add Component:',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 14
                  ),
                ),

                space(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapCamera();
                      },
                      child: Container(
                        width: 53,
                        height: 53,
                        alignment: Alignment.center,

                        child: const Icon(
                          Icons.video_call_rounded,
                          color: Colors.white,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: borderRadius(25)
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapGallery();
                      },
                      child: Container(
                        width: 53,
                        height: 53,
                        alignment: Alignment.center,

                        child: const Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),

                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: borderRadius(25)
                        ),
                      ),
                    ),
                    
                  ],
                ),

                space(20),

              ],
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54,width: 1),
              borderRadius: borderRadius(25)
            ),
          ),
        );
      }
    ); 
  }

  static imageDialog({required Function onTapCamera,required Function onTapGallery}){
    showDialog(
      context: navigatorKey.currentContext!, 
      barrierColor: Colors.white.withOpacity(.6),
      builder: (_){
        return Dialog(
          insetPadding: padding(horizontal: 20),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: padding(),
            width: getSize().width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                space(16),

                const Text(
                  'Add Component:',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 14
                  ),
                ),

                space(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapCamera();
                      },
                      child: Container(
                        width: 53,
                        height: 53,
                        alignment: Alignment.center,

                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: borderRadius(25)
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapGallery();
                      },
                      child: Container(
                        width: 53,
                        height: 53,
                        alignment: Alignment.center,

                        child: const Icon(
                          Icons.photo,
                          color: Colors.white,
                        ),

                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: borderRadius(25)
                        ),
                      ),
                    ),
                    
                  ],
                ),

                space(20),

              ],
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54,width: 1),
              borderRadius: borderRadius(25)
            ),
          ),
        );
      }
    ); 
  }



  static questionDialog({required Function onTapSingle,required Function onTapMulti}){
    showDialog(
      context: navigatorKey.currentContext!, 
      barrierColor: Colors.white.withOpacity(.6),
      builder: (_){
        return Dialog(
          insetPadding: padding(horizontal: 20),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: padding(),
            width: getSize().width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                space(16),

                const Text(
                  'Add Question:',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 14
                  ),
                ),

                space(20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapSingle();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,

                        child: const Text(
                          'Single\nSelection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8
                          ),
                          textAlign: TextAlign.center,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: borderRadius(27)
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      onTap: (){
                        backRoute();
                        onTapMulti();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        alignment: Alignment.center,

                        child: const Text(
                          'Multi\nSelection',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8
                          ),
                          textAlign: TextAlign.center,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: borderRadius(27)
                        ),
                      ),
                    ),
                    
                  ],
                ),

                space(20),

              ],
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54,width: 1),
              borderRadius: borderRadius(25)
            ),
          ),
        );
      }
    ); 
  }

  static addQuestion(bool isMultiAnswer,Function(CreateLumModel lum) onEnd){

    CreateLumModel lum = CreateLumModel(isMultiAnswer: isMultiAnswer);

    showDialog(
      context: navigatorKey.currentContext!, 
      barrierColor: Colors.white.withOpacity(.6),
      builder: (_){
        return Dialog(
          insetPadding: padding(horizontal: 20),
          backgroundColor: Colors.transparent,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                padding: padding(),
                width: getSize().width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    
                    space(16),
            
                    const Text(
                      'Add Component:',
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 14
                      ),
                    ),
            
                    space(20),
            
                    input(lum.title, lum.nodeTitle, 'Question', false),
                    
                    space(12),
            
                    if(lum.show1State)...{

                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                            child: TextButton(
                              onPressed: (){
                                
                                setState((){
                                  lum.show1State= false;
                                });
                              }, 
                              child: const Icon(Icons.remove_circle,color: Colors.red,)
                            ),
                          ),

                          Expanded(child: input(lum.answer1Text, lum.node1, 'Answer', false)),

                          Checkbox(
                            value: lum.answer1State, 
                            onChanged: (v){

                              if(!isMultiAnswer){
                                lum.offAllInput();
                              }

                              setState((){
                                lum.answer1State = v!;
                              });
                            },
                            activeColor: Colors.green,
                          )
                        ],
                      )
                    },

                    space(12),
            
                    if(lum.show2State)...{

                      Row(
                        children: [

                          SizedBox(
                            width: 40,
                            child: TextButton(
                              onPressed: (){
                                setState((){
                                  lum.show2State= false;
                                });
                              }, 
                              child: const Icon(Icons.remove_circle,color: Colors.red,)
                            ),
                          ),

                          Expanded(child: input(lum.answer2Text, lum.node2, 'Answer', false)),

                          Checkbox(
                            value: lum.answer2State, 
                            onChanged: (v){

                              if(!isMultiAnswer){
                                lum.offAllInput();
                              }

                              setState((){
                                lum.answer2State = v!;
                              });
                            },
                            activeColor: Colors.green,
                          )
                        ],
                      )
                    },
                    
                    space(12),
            
                    if(lum.show3State)...{

                      Row(
                        children: [

                          SizedBox(
                            width: 40,
                            child: TextButton(
                              onPressed: (){
                                
                                setState((){
                                  lum.show3State= false;
                                });
                              }, 
                              child: const Icon(Icons.remove_circle,color: Colors.red,)
                            ),
                          ),

                          Expanded(child: input(lum.answer3Text, lum.node3, 'Answer', false)),

                          Checkbox(
                            value: lum.answer3State, 
                            onChanged: (v){
                              if(!isMultiAnswer){
                                lum.offAllInput();
                              }
                              setState((){
                                lum.answer3State = v!;
                              });
                            },
                            activeColor: Colors.green,
                          )
                        ],
                      )
                    },
                    
                    space(12),
            
                    if(lum.show4State)...{

                      Row(
                        children: [

                          SizedBox(
                            width: 40,
                            child: TextButton(
                              onPressed: (){
                                setState((){
                                  lum.show4State= false;
                                });
                              }, 
                              child: const Icon(Icons.remove_circle,color: Colors.red,)
                            ),
                          ),

                          Expanded(child: input(lum.answer4Text, lum.node4, 'Answer', false)),
                          
                          Checkbox(
                            value: lum.answer4State, 
                            onChanged: (v){

                              if(!isMultiAnswer){
                                lum.offAllInput();
                              }
                              setState((){
                                lum.answer4State = v!;
                              });
                            },
                            activeColor: Colors.green,
                          )
                        ],
                      )
                    },
                    
                    space(12),
            
                    if(lum.show5State)...{

                      Row(
                        children: [

                          SizedBox(
                            width: 40,
                            child: TextButton(
                              onPressed: (){
                                setState((){
                                  lum.show5State= false;
                                });
                              }, 
                              child: const Icon(Icons.remove_circle,color: Colors.red,)
                            ),
                          ),

                          Expanded(child: input(lum.answer5Text, lum.node5, 'Answer', false)),
                          
                          Checkbox(
                            value: lum.answer5State, 
                            onChanged: (v){
                              if(!isMultiAnswer){
                                lum.offAllInput();
                              }
                              setState((){
                                lum.answer5State = v!;
                              });
                            },
                            activeColor: Colors.green,
                          )
                        ],
                      )
                    },
            
                    space(20),

                    if(lum.isShowAddButton())...{
                      TextButton(
                        onPressed: (){
                          
                          if(!lum.show1State){
                            lum.show1State = true;
                          } else if(!lum.show2State){
                            lum.show2State = true;
                          } else if(!lum.show3State){
                            lum.show3State = true;
                          } else if(!lum.show4State){
                            lum.show4State = true;
                          } else if(!lum.show5State){
                            lum.show5State = true;
                          }
                          
                          setState((){});
                        }, 
                        child: Row(
                          children: const [
                            Icon(Icons.add_box_rounded,color: Colors.green),

                            Text(
                              ' Add Answer',
                              style: TextStyle(
                                color: Colors.green
                              ),
                            )
                          ],
                        )
                      ),
                    },

                    space(20),

                    Row(
                      children: [

                        Expanded(
                          child: button(
                            onTap: (){
                              backRoute();
                            }, 
                            text: 'Cancel', 
                            bgColor: Colors.white, 
                            textColor: blueColor,
                            borderColor: blueColor,
                            radius: 100,
                            fontSize: 12,
                            height: 32
                          )
                        ),

                        space(0,width: 20),

                        Expanded(
                          child: button(
                            onTap: (){
                              print(lum.title.text);
                              if(lum.title.text.trim().isNotEmpty){
                                backRoute();
                                onEnd(lum);
                              }
                            }, 
                            text: 'Ok', 
                            bgColor: blueColor, 
                            textColor: Colors.white,
                            radius: 100,
                            fontSize: 12,
                            height: 32
                          )
                        ),
                        
                      ],
                    ),

                    space(20),
            
                  ],
                ),
            
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black54,width: 1),
                  borderRadius: borderRadius(25)
                ),
              );
            },

          ),
        );
      }
    );

  }



  static successDialog(){
    showDialog(
      barrierDismissible: false,
      context: navigatorKey.currentContext!, 
      barrierColor: Colors.white.withOpacity(.6),
      builder: (_){
        return Dialog(
          insetPadding: padding(horizontal: 20),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: padding(),
            width: getSize().width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                
                space(16),

                const Text(
                  'Success',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 14
                  ),
                ),

                space(20),

                const Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                ),

                space(20),

                const Text(
                  'Thank you! Your micro-course was successfully created and sent to the moderators for verification',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13
                  ),  
                  textAlign: TextAlign.center,
                ),

                space(20),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      navigatorKey.currentContext!.read<CreateLumProvider>().clear();
                      backRoute();
                      backRoute();
                      backRoute();
                      backRoute();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: const Text(
                      'Go it!',
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 15
                      ),
                    ),
                  ),
                ),

                space(20),

              ],
            ),

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black54,width: 1),
              borderRadius: borderRadius(25)
            ),
          ),
        );
      }
    ); 
  }

} 