
import 'dart:convert';

import 'package:conquerer/models/category_model.dart';
import 'package:conquerer/services/category_service.dart';
import 'package:conquerer/services/response_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:http/http.dart';

import '../pages/main_pages/category_page/lums_page.dart';
import '../resource/app_resource.dart';
import '../resource/colors.dart';
import '../services/base_url.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


Size getSize(){
  return MediaQuery.of(navigatorKey.currentContext!).size;
}
 
Widget space(double height,{double width = 0}){
  return SizedBox(
    height: height,
    width: width,
  );
}

Directionality directionality({required Widget child}){
  return Directionality(
    textDirection: TextDirection.ltr,
    child: child
  );
}

closeSnackBar(){
  ScaffoldMessenger.of(navigatorKey.currentContext!).hideCurrentSnackBar();
}

Widget loading(Color color,{double stroke = 3.5}){
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: stroke,
      valueColor: AlwaysStoppedAnimation<Color>(color),
    ),
  );
}

nextRoute(Widget page,{bool isClearBackRoutes=false}){

  if(isClearBackRoutes){
    Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,MaterialPageRoute(builder: (context) => page), (route) => false);
  }else{
    Navigator.push(navigatorKey.currentContext!,MaterialPageRoute(builder: (context) => page));
  }

}

backRoute(){
  navigatorKey.currentState!.pop();
}

BorderRadius borderRadius(int radius){
  return BorderRadius.circular(radius.toDouble());
}

EdgeInsets padding({int horizontal=30,int vertical =0}){
  return EdgeInsets.symmetric(horizontal: horizontal.toDouble() ,vertical: vertical.toDouble());
}

Widget button({required Function onTap, required String text, required Color bgColor, required Color textColor, int radius = 5,bool isIcon=false,String? iconPath,Color? borderColor,int borderWidth=1,int height=54,bool isLoading=false,int fontSize=20}){
  return GestureDetector(
    onTap: () {
      if(!isLoading){
        onTap();
      }
    },
    behavior: HitTestBehavior.opaque,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isLoading ? height.toDouble() : getSize().width,
      height: height.toDouble(),
      alignment: Alignment.center,
      child: isLoading 
      ? Padding(
          padding: const EdgeInsets.all(6),
          child: loading(Colors.white),
        )
      : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize.toDouble()
            )
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: borderRadius( isLoading ? 200 : radius ),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth.toDouble()
        ),
        color: bgColor
      ),
    ),
  );
}

showError(Response res){

  if(res.statusCode == 422){
    jsonDecode(res.body)['errors'].forEach((key,value){
      showSnackBar(value.first.toString(), Colors.red);
      return;
    });
  }else{
    showSnackBar(jsonDecode(res.body)['message'], Colors.red);
  }

}

showErrorMultipart(AppResponseModel res){

  if(res.statusCode == 422){
    res.data['errors'].forEach((key,value){
      showSnackBar(value.first.toString(), Colors.red);
      return;
    });
  }else{
    showSnackBar(jsonDecode(res.data)['message'], Colors.red);
  }

}

Widget input(TextEditingController controller, FocusNode node,String lable,bool isShowError,{FormFieldValidator<String>? validator , bool isPassword=false, bool isObscure=false,Function? onTapChangeObscure,int line=1,int radius=5, int verticalPadding=0,List<TextInputFormatter>? inputFormatter, bool keyboardIsNumber=false,String hint='',bool isNextNode=false,FocusNode? nextNode, bool enabled=true}){
  return TextFormField(
    controller: controller,
    focusNode: node,
    enabled: enabled,
  
    validator: validator,
    // style: interBold16White(),
    keyboardType: keyboardIsNumber ? TextInputType.number : TextInputType.text,
  
    obscureText: isObscure,
    maxLines: line,
  
    inputFormatters: inputFormatter,
    onFieldSubmitted: (value){
      if(isNextNode){
        nextNode!.requestFocus();
      }
    },
  
    decoration: InputDecoration(
  
      alignLabelWithHint: true,
      hintText: hint,
  
      suffixIcon: isPassword 
      ? GestureDetector(
          onTap: (){
            onTapChangeObscure!();
          },
          behavior: HitTestBehavior.opaque,
          child: const Icon(Icons.remove_red_eye,color: Colors.black54,),
        )
      : const SizedBox(),
      
      contentPadding: padding(horizontal: 16,vertical: verticalPadding),
  
      labelStyle: const TextStyle(
        color: Colors.black,
        fontSize: 17
      ),
      labelText: lable,

      disabledBorder:  OutlineInputBorder(
        borderRadius: borderRadius(radius),
        gapPadding: 6,
        borderSide: const BorderSide(
          width: 1
        ),
      ),
  
  
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius(radius),
        gapPadding: 6,
        borderSide: const BorderSide(
          width: 1
        ),
      ),
  
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius(radius),
        gapPadding: 5,
        // borderSide: const BorderSide(
        //   color: grey5Color,
        //   width: 1
        // ),
      ),
  
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius(radius),
        gapPadding: 6,
        borderSide: const BorderSide(
          width: 1
        ),
      ),
      
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius(radius),
        gapPadding: 6,
      ),
  
      // errorStyle: robotoReqular14White().copyWith(
      //   color: redColor,
      //   fontSize: 13
      // )
    ),
  );
}

Widget searchInput(TextEditingController controller, FocusNode node,String lable,{required Function onTapSearch, int line=1,int radius=5, int verticalPadding=0,List<TextInputFormatter>? inputFormatter, bool keyboardIsNumber=false,String hint='',bool isNextNode=false,FocusNode? nextNode}){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: borderRadius(radius)
    ),
    child: TextFormField(
      
      controller: controller,
      focusNode: node,
  
      // style: interBold16White(),
      keyboardType: keyboardIsNumber ? TextInputType.number : TextInputType.text,
  
      maxLines: line,
      style: const TextStyle(color: Colors.black87),
  
      inputFormatters: inputFormatter,
      onFieldSubmitted: (value){
        onTapSearch();
      },
  
  
      decoration: InputDecoration(

        alignLabelWithHint: true,
        hintText: hint,
  
        suffixIcon:  GestureDetector(
            onTap: (){
              onTapSearch();
            },
            behavior: HitTestBehavior.opaque,
            child: const Icon(Icons.search_sharp,color: Colors.black54,),
          ),
        
        contentPadding: padding(horizontal: 16,vertical: verticalPadding),
  
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 17
        ),
        labelText: lable,
  
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius(radius),
          gapPadding: 6,
          borderSide: const BorderSide(
            width: 1
          ),
        ),
  
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius(radius),
          gapPadding: 5,
          // borderSide: const BorderSide(
          //   color: grey5Color,
          //   width: 1
          // ),
        ),
  
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius(radius),
          gapPadding: 6,
          borderSide: const BorderSide(
            width: 1
          ),
        ),
        
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius(radius),
          gapPadding: 6,
        ),
  
        // errorStyle: robotoReqular14White().copyWith(
        //   color: redColor,
        //   fontSize: 13
        // )
      ),
    ),
  );
}

showSnackBar(String? title,Color bgColor,{int time=3,int fontSize=15}){
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(SnackBar(
    content: SizedBox(
      width: getSize().width,
      height: 45,
      child: Row(
        children: [
          
          Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white
            ),
          ),
        ],
      ),
    ),
    duration:  Duration(seconds: time),
    backgroundColor: bgColor,
  ));
}


Widget fadeImage(String path, double width, double height,{int borderRadius=0}){
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius.toDouble()),
    child: FadeInImage(
      placeholder: const AssetImage(AppResource.placePng),
      image: NetworkImage(path),
      width: width,
      height: height,
      fit: BoxFit.cover,
    ),
  );
}



class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 3.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

Widget title(String data){
  return Padding(
    padding: padding(),
    child: Text(
      data,
      style: const TextStyle(
        color: blueColor,
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}

Widget horizontalListView(List<CategoryModel> data){
  return SizedBox(
    width: getSize().width,
    height: 150,

    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 30,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            nextRoute(LumsPage(data[index]));
          },
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            width: 120,
            height: 150,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Spacer(),const Spacer(),

                Image.network(
                  domain + (data[index].data?.logo ?? ''),
                  width: 45,
                ),

                const Spacer(),

                Text(
                  data[index].title ?? '',
                  style: const TextStyle(
                    color: Colors.white
                  ),
                ),

                const Spacer(),const Spacer(),

              ],
            ),

            decoration: BoxDecoration(
              color: data[index].data!.color,
              borderRadius: borderRadius(25)
            ),
          )
        );
      },
    ),
  );
}


