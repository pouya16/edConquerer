import 'package:conquerer/pages/auth_pages/info_page.dart';
import 'package:conquerer/pages/auth_pages/login_page.dart';
import 'package:conquerer/pages/splash_page/splash_page.dart';
import 'package:conquerer/provider/create_lum_provider.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CreateLumProvider()),
      ],
      child: MaterialApp(
        title: 'Conquerer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xffF7F7F7)
        ),
        navigatorKey: navigatorKey,
        home: SplashPage(),
      ),
    );
  }
}

