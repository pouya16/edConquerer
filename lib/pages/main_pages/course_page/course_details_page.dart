import 'dart:ui';

import 'package:conquerer/models/challenge_model.dart';
import 'package:conquerer/pages/main_pages/course_page/course_pages_page.dart';
import 'package:conquerer/resource/colors.dart';
import 'package:conquerer/services/base_url.dart';
import 'package:conquerer/services/challenge_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

class CourceDetailsPage extends StatefulWidget {
  ChallengeModel challenge;
  CourceDetailsPage(this.challenge,{ Key? key }) : super(key: key);

  @override
  _CourceDetailsPageState createState() => _CourceDetailsPageState();
}

class _CourceDetailsPageState extends State<CourceDetailsPage> {

  ChallengeModel? challenge;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    
    challenge = await ChallengeService.getChallengeDetails(widget.challenge.id!);
    
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        body: Stack(
          children: [
        
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: getSize().width,
                height: 250,
                    
                child: fadeImage(domain + (widget.challenge.data?.cover ?? ''), getSize().width, 250),
              ),
            ),
        
        
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: SizedBox(
                width: getSize().width,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4,sigmaY: 4),
                    child: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.black.withOpacity(.15),
                      automaticallyImplyLeading: false,
                      title: Row(
                        children: [
                
                          Row(
                            children: [
                              IconButton(
                                onPressed: (){
                                  backRoute();
                                }, 
                                icon: const Icon(Icons.arrow_back_ios,size: 20,)
                              ),
                
                              Text(
                                widget.challenge.title ?? '',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18
                                ),
                              ),
                
                            ],
                          ),
                
                          const Spacer(),
                          
                          // Row(
                          //   children: [
                              
                          //     const Text(
                          //       ' 250 ',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.bold
                          //       ),
                          //     ),
                
                          //     const Icon(Icons.star,size: 23,),
                              
                          //     IconButton(
                          //       constraints: const BoxConstraints(minWidth: 40),
                          //       onPressed: (){
                
                          //       }, 
                          //       padding: padding(horizontal: 2),
                          //       icon: const Icon(Icons.favorite_border),
                          //       iconSize: 25,
                          //     ),
                
                
                          //   ],
                          // ),
                
                        ],
                      ),
                
                    ),
                  ),
                ),
              ),
            ),


            Positioned.fill(
              top: 230,
              child: Container(
                width: getSize().width,
                height: getSize().height,

                child: isLoading
              ? loading(blueColor)
              : SingleChildScrollView(
                  padding: padding(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [

                      space(30),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          
                          const Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),  
                          ),

                          SizedBox(
                            width: getSize().width * .3,
                            height: 32,
                            child: button(
                              onTap: (){
                                if(challenge!.pages!.isNotEmpty){
                                  nextRoute(CoursePagesPage(challenge!,false));
                                }
                              }, 
                              text: 'Subscribe', 
                              bgColor: blueColor,
                              textColor: Colors.white,
                              fontSize: 12,
                              radius: 40
                            ),
                          ),

                        ],
                      ),

                      space(30),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          challenge?.data?.description ?? '',
                          style: const TextStyle(
                            fontSize: 14
                          ),
                        ),
                      ),
                      
                      space(30),

                      // item('Estimated time to conquer', '4:35'),

                      // item('points given for conquer', '235'),

                      // item('points needed to subscribe', '235'),
                      
                      item('page Numbers', challenge?.pageCount?.toString() ?? '-'),

                      space(30),

                      
                    ],
                  ),
                ),
                        
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15),
                  )
                ),
              ),
            ),
          
          ],
        ),
      )
    );
  }


  Widget item(String text, String decs){
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: getSize().width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
          
            Text(
              text,
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
      
      
            Text(
              decs,
              style: const TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
      
      
          ],
        ),
      ),
    );

  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, 0);
    path.lineTo(0, size.height - 20);

    path.quadraticBezierTo(0, size.height, 50, size.height - 20);
    
    path.lineTo(size.width - 20, size.height - 20);
    
    path.quadraticBezierTo(size.width - 10, size.height, size.width, size.height,);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}