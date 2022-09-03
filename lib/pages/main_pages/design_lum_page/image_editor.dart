import 'dart:io';

import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class ImageEditor extends StatefulWidget {
  File image;
  ImageEditor(this.image,{ Key? key }) : super(key: key);

  @override
  _ImageEditorState createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {

  ScreenshotController screenshotController = ScreenshotController();

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  List<Color> colors = [Colors.white, Colors.black, Colors.red, Colors.green, Colors.blue, Colors.amber, Colors.cyan, Colors.brown, Colors.orange];
  
  List<Alignment> aligns = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomRight,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  late Color color;
  Alignment alignment = Alignment.center;
  // double heightImage = 0;
  final GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();

    color = colors.first;

    controller.addListener(() {
      setState(() {});

    });    
  }


  save() async {
    final directory = (await getApplicationDocumentsDirectory()).path; //from path_provide package
    String fileName = DateTime.now().microsecondsSinceEpoch.toString() + ".png" ;

    await screenshotController.captureAndSave(
      directory,
      fileName: fileName 
    );

    navigatorKey.currentState!.pop(directory + '/$fileName');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Edit Image',
          style: TextStyle(color: Colors.white),
        ),

        actions: [
          IconButton(
            onPressed: (){
              save();
            }, 
            icon: const Icon(Icons.save_alt_rounded)
          )
        ],
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
      
            Container(
              padding: padding(vertical: 18),
              width: getSize().width,
              color: Colors.white,
              child: input(controller, node, 'text', false,line: 4,verticalPadding: 12,)
            ),
      
            Stack(
              children: [
            
                Screenshot(
                  controller: screenshotController,
                  child: Stack(
                    // alignment: Alignment.topCenter,
                    children: [

                      Image.file(
                        widget.image,
                        key: key,
                        width: getSize().width,
                        fit: BoxFit.fitWidth,
                      ),
                      
                      
      
                      Positioned(
                        top: 5,
                        right: 5,
                        left: 5,
                        bottom: 5,
                        child: Align(
                          alignment: alignment,
                          child: Text(
                            controller.text,
                            style: TextStyle(
                              color: color,
                              fontSize: 18
                            ),
                          ),
                        ),
                      )
                
                    ],
                  ),
                ),
                
              ],
            ),
      
            space(20),
      
            SizedBox(
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
      
                  ...List.generate(colors.length, (index) {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          color = colors[index];
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: padding(horizontal: 12,vertical: 12),
                        decoration: BoxDecoration(
                          color: colors[index],
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 10,
                              spreadRadius: -4
                            )
                          ]
                        ),
                      ),
                    );
                  })
                ],
              )
            ),

            space(20),
            
            SizedBox(
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
      
                  ...List.generate(aligns.length, (index) {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          alignment = aligns[index];
                        });
                      },
                      child: Container(
                        width: getSize().width * .3,
                        height: 50,
                        alignment: Alignment.center,

                        child: Text(
                          aligns[index].toString().split('.').last,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    );
                  })
                ],
              )
            ),

            space(50),


          ],
        ),
      ),

    );
  }
}