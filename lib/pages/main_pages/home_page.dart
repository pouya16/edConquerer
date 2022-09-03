import 'package:conquerer/data/data.dart';
import 'package:conquerer/resource/colors.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController controller = TextEditingController();
  FocusNode node = FocusNode();

  String name = '';
  @override
  void initState() {
    super.initState();

    init();
  }

  init() async {
    name = await AppData.getName();
    setState(() {});
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

                  Text(
                    'Hi $name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),

                  const Spacer(),
                  
                  
                  Row(
                    children: [
                      
                      
                      const Icon(Icons.star,size: 23,),
                      
                      IconButton(
                        constraints: const BoxConstraints(minWidth: 40),
                        onPressed: (){

                        }, 
                        padding: padding(horizontal: 2),
                        icon: const Icon(Icons.notifications),
                        iconSize: 25,
                      ),


                    ],
                  ),



                ],
              ),

              space(24),

              searchInput(controller, node, 'Search', onTapSearch: (){

              }),

              space(12),

            ],
          ),
        
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [

              // space(20),

              // title('Categories for you:'),

              // space(20),

              // horizontalListView(),



              // space(20),

              // title('Lum for you:'),

              // space(20),

              // horizontalListView(),



              // space(20),

              // title('Favorites:'),

              // space(20),

              // horizontalListView(),



              // space(20),

              // title('Continue to Conquer:'),

              // space(20),

              // horizontalListView(),

            ],
          ),
        ),

      )
    );
  }
}