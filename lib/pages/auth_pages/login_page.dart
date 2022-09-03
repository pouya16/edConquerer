import 'package:conquerer/pages/auth_pages/forget_password_page.dart';
import 'package:conquerer/pages/auth_pages/sign_up_page.dart';
import 'package:conquerer/pages/main_pages/main_page.dart';
import 'package:conquerer/resource/colors.dart';
import 'package:conquerer/services/auth_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordNode = FocusNode();

  bool isObscurePassword = true;
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        body: Padding(
          padding: padding(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              const Spacer(),
              const Spacer(),
              const Spacer(),

              input(emailController, emailNode, 'Email', false,hint: 'email@provider.com',isNextNode: true,nextNode: passwordNode),

              space(50),

              input(passwordController, passwordNode, 'Password', false,isObscure: isObscurePassword,isPassword: true,onTapChangeObscure: (){
                setState(() {
                  isObscurePassword = !isObscurePassword;
                });
              }),

              const Spacer(),

              button(
                onTap: ()async{
                  if(emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty){
                    
                    setState(() {
                      isLoading = true;
                    });
                    
                    bool res = await AuthService.login(emailController.text.trim(), passwordController.text.trim());


                    if(res){
                      nextRoute(const MainPage(),isClearBackRoutes: true);
                    }
                    
                    setState(() {
                      isLoading = false;
                    });

                  }
                }, 
                text: 'Login', 
                bgColor: blueColor, 
                textColor: Colors.white,
                isLoading: isLoading
              ),

              space(40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [

                  const Text('or ',style: TextStyle(fontSize: 18)),

                  GestureDetector(
                    onTap: (){
                      nextRoute(const SignupPage());
                    },
                    behavior: HitTestBehavior.opaque,
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),

                ],
              ),

              space(12),

              GestureDetector(
                onTap: (){
                  nextRoute(const ForgetPasswordPage());
                },
                behavior: HitTestBehavior.opaque,
                child: const Text(
                  'Forget Password',
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 16
                  ),
                ),
              ),


              const Spacer(),
              const Spacer(),


            ],
          ),
        ),
      )
    );
  }
}