import 'package:conquerer/pages/main_pages/category_page/sub_category_page.dart';
import 'package:conquerer/pages/main_pages/design_lum_page/design_lum_page.dart';
import 'package:conquerer/services/base_url.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

import '../../../models/category_model.dart';
import '../../../resource/colors.dart';
import '../../../services/category_service.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({ Key? key }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  // ScrollController scrollController = ScrollController();
  bool isLoading = false;

  List<CategoryModel> categoryData = [];
  // int page = 0;
  

  @override
  void initState() {
    super.initState();

    // scrollController.addListener(() {
    //   double current = scrollController.position.pixels;
    //   double max = scrollController.position.maxScrollExtent;


    //   if(max - current < 300){
    //     if(!isLoading){
    //       getData();
    //     }
    //   }
    // });


    getData();
  }

  getData(){

    setState(() {
      isLoading=true;
    });

    CategoryService.getCategory(controller.text.trim()).then((value) {
      setState(() {
        categoryData += value;
        isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return directionality(
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
          titleSpacing: 24 ,

          title: searchInput(controller, node, 'Search Topics', onTapSearch: (){
            categoryData.clear();
            getData();
          }),
        ),

        body: SingleChildScrollView(
          // controller: scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              space(20),

              ...List.generate(categoryData.length, (index) {
                return listItem(index);
              }),

              isLoading ? loading(blueColor) : Container(),

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

      ),

    );
  }


  Widget listItem(int index,){
    return GestureDetector(
      onTap: (){
        nextRoute(SubCategoryPage(categoryData[index]));
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
              categoryData[index].title ?? '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),

            Image.network(
              domain + (categoryData[index].data?.logo ?? ''),
              width: 45,
            ),

          ],
        ),
        decoration: BoxDecoration(
          color: categoryData[index].data?.color,
          borderRadius: borderRadius(25)
        ),
      ),
    );
 
  }

}