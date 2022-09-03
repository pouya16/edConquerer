import 'package:conquerer/data/data.dart';
import 'package:conquerer/pages/auth_pages/info_page.dart';
import 'package:conquerer/pages/auth_pages/login_page.dart';
import 'package:conquerer/resource/app_resource.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../resource/colors.dart';
import '../auth_pages/term_of_use_page.dart';
import '../moderating_page/moderating_page.dart';
import 'design_lum_page/design_lum_page.dart';

class ProfilePage extends StatefulWidget {
  
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String token = '';

  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {

    token = await AppData.getToken();

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return SafeArea(
      bottom: false,
      child: Scaffold(
        
        body: Column(
          children: [

            if(token.isNotEmpty)...{
              item('Profile', onTap: ()=> nextRoute(const InfoPage(isProfile: true,)) ),
            },

            item('Progress'),

            item('Moderate',onTap: ()=> nextRoute(const ModeratingPage())),

            /*item('Reset Password', onTap: () => nextRoute(const ResetPasswordPage())),*/

            item('Account And Privacy',onTap: (){
              showDialog(
                context: context,
                builder: (cnt){
                  return Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        space(20),

                        // Privacy Policy
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

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

                        space(10),

                        // Terms
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

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

                        space(10),

                        
                        // code of conduct 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

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

                        space(20),

                      
                      ],
                    ),
                  );
                }
              );
            }),

            // item('Setting'),

            // item('Credit'),

            item('Design',onTap: ()=> nextRoute(DesignLumPage(false))),

            item( token.isNotEmpty ? 'Log out': 'Log In',onTap: (){
              AppData.saveToken('');
              nextRoute(const LoginPage(),isClearBackRoutes: true);
            }),

          ],
        ),

      ),
    );
  }

  Widget item(String text,{Function?onTap}){
    return Padding(
      padding: padding(),
      child: GestureDetector(
        onTap: (){
          if(onTap != null){
            onTap();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [

            space(12),
            
            Row(
              children: [
      
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),  
                ),
      
                const Spacer(),
      
                SvgPicture.asset(AppResource.workSvg)
      
              ],
            ),
            
            space(12),

            const Divider(color: Colors.black, thickness: .8,)

      
          ],
        ),
      ),
    );
  }
}