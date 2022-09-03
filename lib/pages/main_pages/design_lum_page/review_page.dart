import 'package:conquerer/pages/main_pages/design_lum_page/add_content_page.dart';
import 'package:conquerer/pages/main_pages/design_lum_page/add_question_page.dart';
import 'package:conquerer/pages/main_pages/design_lum_page/design_lum_page.dart';
import 'package:conquerer/provider/create_lum_provider.dart';
import 'package:conquerer/services/challenge_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:conquerer/widgets/create_lum_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../resource/colors.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({ Key? key }) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  bool isLoading = false;

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
                  onPressed: () {
                    if(!isLoading){
                      backRoute();
                    }
                  }, 
                  icon: const Icon(Icons.arrow_back_ios),
                  padding: padding(horizontal: 0),
                ),
              ),

              const Text(
                'Review',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),
              ),


              const Spacer(),

              
              
              IconButton(
                onPressed: () async {

                  setState(() {
                    isLoading = true;
                  });

                  for (var item in context.read<CreateLumProvider>().pages) {
                    bool res = await ChallengeService.createPage(
                      context.read<CreateLumProvider>().challengeId, 
                      item
                    );
                  }
                  
                  setState(() {
                    isLoading = false;
                  });

                  CreateLumWidget.successDialog();

                }, 
                icon: isLoading
                ? loading(Colors.white)
                : const Icon(Icons.check,color: Colors.white,)
              ),
              
            ],
          ),
        ),

        body: Padding(
          padding: padding(vertical: 20),
          child: SingleChildScrollView(
            child: SizedBox(
              width: getSize().width,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 12,
                runSpacing: 12,
                children: [

                  ...List.generate(context.read<CreateLumProvider>().pages.length, (index) {
                    return Column(
                      children: [

                        GestureDetector(
                          onTap: (){
                            context.read<CreateLumProvider>().currentPage = index;
                            nextRoute(AddContentPage(true));
                          },
                          child: DottedBorder(
                            color: Colors.grey,
                            strokeWidth: 2,
                            radius: const Radius.circular(5),
                            dashPattern: const [4, 4],
                            borderType: BorderType.RRect,
                            child: Container(
                              width: getSize().width * .25,
                              height: getSize().width * .25,
                              alignment: Alignment.center,
                        
                              child: Text(
                                (index + 1).toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20
                                ),
                              ),
                                
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        space(10),

                        SizedBox(
                          width: getSize().width * .25,
                          child: button(
                            onTap: (){
                              context.read<CreateLumProvider>().pages.removeAt(index);
                              setState(() {});
                              
                              context.read<CreateLumProvider>().currentPage = context.read<CreateLumProvider>().pages.length - 1;
                            }, 
                            text: 'Delete', 
                            bgColor: Colors.red, 
                            textColor: Colors.white,
                            radius: 50,
                            fontSize: 12,
                            height: 30
                          ),
                        )


                      ],
                    );
                  })

                ],
              ),
            ),
          ),
        ),

      )
    );
  }
}