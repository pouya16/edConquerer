import 'package:conquerer/models/category_model.dart';
import 'package:conquerer/services/category_service.dart';
import 'package:conquerer/services/user_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

import '../../../resource/colors.dart';
import '../../../services/base_url.dart';
import '../design_lum_page/design_lum_page.dart';
import 'lums_page.dart';

class SubCategoryPage extends StatefulWidget {
  CategoryModel parent;
  SubCategoryPage(this.parent,{ Key? key }) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  bool isLoading = false;
  bool isLoadingFav = false;

  List<CategoryModel> subs = [];


  bool fav = false;

  @override
  void initState() {
    super.initState();

    getData();
  }


  getData() async {
    setState(() {
      isLoading = true;
    });
    
    subs = await CategoryService.getSubCategory(widget.parent.id!);
    
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
                        widget.parent.title ?? '',
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
                        '   ${widget.parent.points } ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      const Icon(Icons.star,size: 23,),
                      
                      // isLoadingFav
                      // ? loading(Colors.white)
                      // : IconButton(
                      //     constraints: const BoxConstraints(minWidth: 40),
                      //     onPressed: () async {
                      //       setState(() {
                      //         isLoadingFav = true;
                      //         fav = !fav;
                      //       });
                            
                      //       bool res = await UserService.addToFavorite(widget.parent.id!);
                            
                      //       setState(() {
                      //         isLoadingFav = false;
                      //       });
                      //     }, 
                      //     padding: padding(horizontal: 2),
                      //     icon: Icon( fav ? Icons.favorite :  Icons.favorite_border, color: fav ? Colors.red : Colors.white,),
                      //     iconSize: 25,
                      //   ),


                    ],
                  ),



                ],
              ),

              space(12),

              searchInput(controller, node, 'Search Sub Topics', onTapSearch: (){
                subs.clear();
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

              Padding(
                padding: padding(horizontal: 40),
                child: const Text(
                  'Sub Topics:',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),

              space(12),

              ...List.generate(subs.length, (index) {
                return listItem(index);
              }),

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


  Widget listItem(int index,){
    return GestureDetector(
      onTap: (){
        nextRoute(LumsPage(subs[index]));
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: getSize().width,
        height: 110,
        margin: padding(vertical: 8),
        padding: padding(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text(
              subs[index].title ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),

            Image.network(
              domain + (subs[index].data?.logo ?? ''),
              width: 45,
            ),

          ],
        ),
        decoration: BoxDecoration(
          color: subs[index].data?.color,
          borderRadius: borderRadius(25)
        ),
      ),
    );
 
  }
}