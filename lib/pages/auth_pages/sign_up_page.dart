import 'package:conquerer/pages/auth_pages/info_page.dart';
import 'package:conquerer/pages/auth_pages/term_of_use_page.dart';
import 'package:conquerer/services/auth_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

import '../../resource/colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({ Key? key }) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  
  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();

  TextEditingController passwordController = TextEditingController();
  FocusNode passwordNode = FocusNode();
  
  TextEditingController codeController = TextEditingController();
  FocusNode codeNode = FocusNode();

  bool isObscurePassword = true;
  bool isSendVerifycationCode = false;

  bool isAcceptTerm=true;
  bool isAcceptPrivacyPolicy=true;
  bool isAcceptPrivacyCodeOfConduct=true;
  bool isLoading=false;


  bool isShowSignup = true;

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(
        body: Padding(
          padding: padding(),
          child: Column(
            children: [

              const Spacer(),
              const Spacer(),
              const Spacer(),

              if(isShowSignup)...{

                input(emailController, emailNode, 'Email', false,hint: 'email@provider.com',isNextNode: true,nextNode: codeNode),

                space(35),

                input(passwordController, passwordNode, 'Password', false,isObscure: isObscurePassword,isPassword: true,onTapChangeObscure: (){
                  setState(() {
                    isObscurePassword = !isObscurePassword;
                  });
                }),

                const Spacer(),

                // Privacy Policy
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Checkbox(
                      activeColor: blueColor,
                      value: isAcceptPrivacyPolicy, 
                      onChanged: (v){
                        setState(() {
                          isAcceptPrivacyPolicy = v!;
                        });
                      }
                    ),

                    const Text(
                      'I agree to ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        nextRoute(TermOfUsePage(PageState.privacyPolicy));
                      },
                      behavior: HitTestBehavior.opaque,
                      child: const Text(
                        'privacy policy',
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                  ],
                ),

                // Terms
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Checkbox(
                      activeColor: blueColor,
                      value: isAcceptTerm, 
                      onChanged: (v){
                        setState(() {
                          isAcceptTerm = v!;
                        });
                      }
                    ),

                    const Text(
                      'I agree to ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        nextRoute(TermOfUsePage(PageState.termsAndConditions));
                      },
                      behavior: HitTestBehavior.opaque,
                      child: const Text(
                        'terms and conditions',
                        style: TextStyle(
                          color: blueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                  ],
                ),
                
                // code of conduct 
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Checkbox(
                    activeColor: blueColor,
                    value: isAcceptPrivacyCodeOfConduct, 
                    onChanged: (v){
                      setState(() {
                        isAcceptPrivacyCodeOfConduct = v!;
                      });
                    }
                  ),

                  const Text(
                    'I agree to ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      nextRoute(TermOfUsePage(PageState.codeOfConduct));
                    },
                    behavior: HitTestBehavior.opaque,
                    child: const Text(
                      'code of conduct',
                      style: TextStyle(
                        color: blueColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),

                ],
              ),
              
              }else...{
                SizedBox(
                  width: getSize().width,
                  height: 48,
                  child: input(codeController, codeNode, 'Verification Code', false,hint: '',isNextNode: true,nextNode: passwordNode)
                ),

                space(10),
              },
              
              button(
                onTap: () async {
                  
                  if(isShowSignup){

                    if(emailController.text.trim().isNotEmpty && passwordController.text.trim().isNotEmpty && (isAcceptTerm && isAcceptPrivacyPolicy && isAcceptPrivacyCodeOfConduct)){

                      setState(() {
                        isLoading = true;
                      });

                      bool res = await AuthService.register(emailController.text.trim(), passwordController.text.trim());


                      setState(() {
                        isShowSignup = !res;
                        isLoading = false;
                      });

                    }
                  }else{
                    
                    if(codeController.text.trim().isNotEmpty){
                      
                      setState(() {
                        isLoading = true;
                      });

                      bool res = await AuthService.accountVerification(codeController.text.trim(), emailController.text.trim());

                      if(res){
                        nextRoute(const InfoPage(isProfile: false));
                      }

                      setState(() {
                        isLoading = false;
                      });

                    }
                  }

                }, 
                text: isShowSignup ? 'Sign Up' : 'Send', 
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
                      backRoute();
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                  ),

                ],
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