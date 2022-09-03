import 'package:conquerer/data/data.dart';
import 'package:conquerer/pages/auth_pages/login_page.dart';
import 'package:conquerer/pages/main_pages/main_page.dart';
import 'package:conquerer/resource/app_resource.dart';
import 'package:conquerer/resource/colors.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {



  @override
  void initState() {
    super.initState();

    init();
  }

  init() async {

    // String token = await AppData.getToken();

    await Future.delayed(const Duration(seconds: 2));

    // if(token.isEmpty){
    //   nextRoute(const LoginPage(),isClearBackRoutes: true);
    // }else{
    // }
    nextRoute(const MainPage(),isClearBackRoutes: true);

  }


  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            space(0,width: getSize().width),

            Center(child: Image.asset(AppResource.logoPng,width: 130,)),

            space(28),

            const Text(
              'edConquer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: greyColor
              ),
            )
          ],
        ),
      ),
    );
  }
}