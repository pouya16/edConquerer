import 'package:conquerer/pages/main_pages/category_page/category_page.dart';
import 'package:conquerer/pages/main_pages/favorite_page.dart';
import 'package:conquerer/pages/main_pages/home_page.dart';
import 'package:conquerer/pages/main_pages/profile_page.dart';
import 'package:conquerer/resource/app_resource.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'history_page.dart';


enum PageNames{
  Favorite,
  Topics,
  Home,
  History,
  More
}



class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  PageNames currentPage = PageNames.Topics;

  Map<PageNames, Widget> pages = {
    PageNames.Favorite : const FavoritePage(),
    PageNames.History : const HistoryPage(),
    PageNames.More : const ProfilePage(),
    PageNames.Topics : const CategoryPage(),
    // PageNames.home : const HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    
    return directionality(
      child: Scaffold(

        body: pages[currentPage],

        bottomNavigationBar: Container(
          height: 62,
          width: getSize().width,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              bottomNavigationItem(PageNames.Favorite.name, AppResource.favoriteSvg, PageNames.Favorite, currentPage,onTapItem),

              bottomNavigationItem(PageNames.Topics.name, AppResource.categorySvg, PageNames.Topics, currentPage,onTapItem),

              bottomNavigationItem(PageNames.Home.name, AppResource.homeSvg, PageNames.Home, currentPage, onTapItem),

              bottomNavigationItem(PageNames.History.name, AppResource.historySvg, PageNames.History, currentPage, onTapItem),

              bottomNavigationItem(PageNames.More.name, AppResource.userSvg,PageNames.More, currentPage, onTapItem),

            ],
          ),

          decoration: const BoxDecoration(
            color: Colors.white,
          ),
        ),
      )
    );
  }

  onTapItem(PageNames newPage){
    setState(() {
      currentPage = newPage;
    });
  }


  Widget bottomNavigationItem(String pageName,String icon,PageNames page,PageNames currentPage,Function(PageNames newPage) onTap){
    return GestureDetector(
      onTap: (){
        onTap(page);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: getSize().width * .15,
        height: 62,
        alignment: Alignment.center,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.only( top: currentPage == page ? 10 : 18 ),
          child: Column(
            children: [
          
              SvgPicture.asset(icon,color: currentPage == page ? const Color(0xFFFAB800) : Colors.black,width: 20, height: 18,),
          
              if(currentPage == page)...{
                space(6),
                
                Text(
                  pageName,
                  style: const TextStyle(
                    color: Color(0xFFFAB800),
                    fontSize: 10
                  ),
                )
              }
          
            ],
          ),
        ),
      ),
    );
  }
}