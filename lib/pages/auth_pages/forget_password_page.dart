import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

import '../../resource/colors.dart';
import '../../services/auth_service.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({ Key? key }) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {

  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: padding(),
        child: Column(
          children: [

            const Spacer(),
            const Spacer(),
            const Spacer(),

            input(emailController, emailNode, 'Email', false,hint: 'email@provider.com',),

            space(50),

            button(
              onTap: ()async{
                if(emailController.text.trim().isNotEmpty){
                  
                  setState(() {
                    isLoading = true;
                  });
                  
                  bool res = await AuthService.forget(emailController.text.trim());


                  if(res){
                    backRoute();
                  }
                  
                  setState(() {
                    isLoading = false;
                  });

                }
              }, 
              text: 'Send', 
              bgColor: blueColor, 
              textColor: Colors.white,
              isLoading: isLoading
            ),

            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}