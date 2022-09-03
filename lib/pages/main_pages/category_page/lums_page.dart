import 'package:conquerer/models/category_model.dart';
import 'package:conquerer/models/challenge_model.dart';
import 'package:conquerer/services/base_url.dart';
import 'package:conquerer/services/challenge_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

import '../../../resource/colors.dart';
import '../../../services/user_service.dart';
import '../course_page/course_details_page.dart';
import '../design_lum_page/design_lum_page.dart';

class LumsPage extends StatefulWidget {
  CategoryModel sub;
  LumsPage(this.sub,{ Key? key }) : super(key: key);

  @override
  _LumsPageState createState() => _LumsPageState();
}

class _LumsPageState extends State<LumsPage> {
  
  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  bool isLoading = false;
  bool isLoadingFav = false;
  bool fav = false;

  List<ChallengeModel> challenges = [];

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {

    setState(() {
      isLoading = true;
    });


    challenges = await ChallengeService.getChallege(widget.sub.id!,controller.text.trim());
    print(challenges.length);

    setState(() {
      isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        
        appBar: AppBar(
          toolbarHeight: 130,
          automaticallyImplyLeading: false,
          shadowColor: Colors.grey[200],
          backgroundColor: blueColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          bottomOpacity: 1,
          titleSpacing: 24 ,

          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              Row(
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
                        widget.sub.title ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),

                    ],
                  ),

                  const Spacer(),
                  
                  
                  Row(
                    children: [
                      
                      Text(
                        '   ${widget.sub.points } ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      const Icon(Icons.star,size: 23,),
                      
                      isLoadingFav
                      ? loading(Colors.white)
                      : IconButton(
                          constraints: const BoxConstraints(minWidth: 40),
                          onPressed: () async {
                            setState(() {
                              isLoadingFav = true;

                              fav = !fav;
                            });
                            
                            bool res = await UserService.addToFavorite(widget.sub.id!);
                            
                            setState(() {
                              isLoadingFav = false;
                            });
                          }, 
                          padding: padding(horizontal: 2),
                          icon: Icon( fav ? Icons.favorite :  Icons.favorite_border, color: fav ? Colors.red : Colors.white,),
                          iconSize: 25,
                        ),


                    ],
                  ),



                ],
              ),

              space(12),

              searchInput(controller, node, 'Search Challenge', onTapSearch: (){
                challenges.clear();
                getData();
              }),

              space(12),

            ],
          ),
        ),

        body: isLoading
      ? loading(blueColor)
      : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              space(20),

              // Padding(
              //   padding: padding(horizontal: 40),
              //   child: const Text(
              //     'Sub Topics:',
              //     style: TextStyle(
              //       color: blueColor,
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold
              //     ),
              //   ),
              // ),

              // space(12),

              SizedBox(
                width: getSize().width,
                child: Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    ...List.generate(challenges.length, (index) {
                      return listItem(index);
                    }),
                  ],
                )
              )

            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: (){
            nextRoute(DesignLumPage(false));
          },
          backgroundColor: goldColor,
          child: const Icon(Icons.add, color: Colors.white),
        ),

      )
    );
  }

  Widget listItem(int index) {
    return SizedBox(
      width: getSize().width * .4,
      child: GestureDetector(
        onTap: (){
          nextRoute(CourceDetailsPage(challenges[index]));
        },
        child: Container(
          margin: padding(vertical: 12,horizontal: 12),
          width: getSize().width * .25,
          height: getSize().width * .45,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Image.network(domain + (challenges[index].data?.icon ?? ''),width: 50,),

              Text(
                challenges[index].title ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              )

            ],
          ),

          decoration: BoxDecoration(
            color: challenges[index].data?.color  ,
            borderRadius: borderRadius(25)
          ),

        ),
      )
    );
  }
}