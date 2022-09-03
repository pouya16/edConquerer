import 'package:conquerer/models/category_model.dart';
import 'package:conquerer/resource/colors.dart';
import 'package:conquerer/services/user_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({ Key? key }) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  List<CategoryModel> data = [];
  List<CategoryModel> categorys = [];
  List<CategoryModel> subCategorys = [];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {

    setState(() {
      isLoading= true;
    });
    
    data = await UserService.getFavorite();
    
    setState(() {
      isLoading= false;
    });

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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

          // title: searchInput(controller, node, 'Search Favorites', onTapSearch: (){

          // }),
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              space(20),

              title('Sub Topics :'),

              space(20),

              isLoading ? loading(blueColor) : Container(),

              horizontalListView(data),
              
              // space(20),

              // title('Sub Categories:'),

              // space(20),

              // horizontalListView(),
              
              // space(20),

              // title('Lums:'),

              // space(20),

              // horizontalListView(),

            ],
          ),
        ),

      )
    );
  }



  
}