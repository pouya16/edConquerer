import 'dart:io';

import 'package:conquerer/models/category_model.dart';
import 'package:conquerer/pages/main_pages/category_page/category_page.dart';
import 'package:conquerer/pages/main_pages/design_lum_page/add_content_page.dart';
import 'package:conquerer/provider/create_lum_provider.dart';
import 'package:conquerer/services/challenge_service.dart';
import 'package:conquerer/services/upload_service.dart';
import 'package:conquerer/utils/image.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import '../../../resource/colors.dart';
import '../../../services/category_service.dart';

class DesignLumPage extends StatefulWidget {

  bool review;
  DesignLumPage(this.review,{ Key? key }) : super(key: key);

  @override
  _DesignLumPageState createState() => _DesignLumPageState();
}

class _DesignLumPageState extends State<DesignLumPage> {

  Color bgColor = Colors.green;
  TextEditingController hexController = TextEditingController(); 
  
  File? iconFile;
  File? coverFile;

  final ImagePicker _picker = ImagePicker();

  TextEditingController titleController = TextEditingController(); 
  FocusNode titleNode = FocusNode();
  
  TextEditingController descController = TextEditingController(); 
  FocusNode descNode = FocusNode();

  CategoryModel? category;
  CategoryModel? subCategory;

  bool isLoadingCategory = false;
  bool isLoadingSubCategory = false;

  List<CategoryModel> categoryData = [];
  List<CategoryModel> subCategoryData = [];

  bool isLoading = false;


  @override
  void initState() {
    super.initState();

    // getImageFileFromAssets('images/png/cover.png').then((value) {
    //   coverFile = value;
    // });
    ImageUtils.imageToFile('cover', 'png').then((value) {
      coverFile = value;
      print(value.path);
    });
    
    ImageUtils.imageToFile('logo', 'png').then((value) {
      iconFile = value;
      print(value.path);
    });
    
    // getImageFileFromAssets('images/png/logo.png').then((value) {
    //   iconFile = value;
    // });

    hexController.text = 'FFBC7DC0';
    
    getData();
  }

  getData(){

    
    setState(() {
      isLoadingCategory = true;
    });


    CategoryService.getCategory('').then((value) {
      setState(() {
        categoryData = value;
        isLoadingCategory = false;
        try{
          category = categoryData.first;
          getSubCategory(category!);
        }catch(e){}
      });
    });

  }


  getSubCategory(CategoryModel cat){
    setState(() {
      isLoadingSubCategory = true;
    });

    CategoryService.getSubCategory(cat.id!).then((value) {
      setState(() {
        subCategoryData = value;
        isLoadingSubCategory = false;
        
      });
    });
    
  }



  selectIcon() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      iconFile = File(image.path);
      setState(() {});
    }
  }
  
  selectCover() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      coverFile = File(image.path);
      setState(() {});
    }
  }



  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: AppBar(
          toolbarHeight: 70,
          shadowColor: Colors.grey[200],
          automaticallyImplyLeading: false,
          backgroundColor: blueColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          bottomOpacity: 1,
          

          title: Row(
            children:  [

              SizedBox(
                width: 40,
                child: IconButton(
                  onPressed: (){
                    if(widget.review){
                      backRoute();
                    }else{
                      context.read<CreateLumProvider>().clear();
                      backRoute();
                    }
                  }, 
                  icon: const Icon(Icons.arrow_back_ios),
                  padding: padding(horizontal: 0),
                ),
              ),

              const Text(
                'Design a Lum',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
              
            ],
          ),
        ),

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: padding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              space(20),

              dotButton(
                (){
                  selectCover();
                },
                'Add Cover Image'
              ),

              space(20),

              Row(
                children: [

                  Expanded(
                    child: dotButton(
                      (){
                        selectIcon();
                      }, 
                      'Add Icon',
                    )
                  ),

                  space(0,width: 20),

                  Expanded(
                    child: dotButton(
                      (){
                        
                        showDialog(
                          context: context,
                          builder: (BuildContext context) { 
                            return AlertDialog(
                              title: const Text('Add Color'),
                              content: SingleChildScrollView(

                                child: ColorPicker(  
                                  hexInputBar: true,
                                  pickerColor: Colors.red,
                                  onColorChanged: (color){
                                    bgColor = color;
                                    
                                  },
                                  hexInputController: hexController,
                                ),
                                
                              ),
                              
                              actions: <Widget>[
                                
                                ElevatedButton(
                                  child: const Text('Got it'),
                                  onPressed: () {
                                    
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                ),

                              ],
                            );
                           },
                        );

                      }, 
                      'Add Color',
                    )
                  ),


                ],
              ),

              space(20),

              Text(
                'Cover: ${basename(coverFile?.path ?? 'Not Selected')}',
              ),
              
              space(12),

              Text(
                'Icon: ${basename(iconFile?.path ?? 'Not Selected')}',
              ),

              space(12),

              Text(
                'Color: ${hexController.text}',
              ),

              space(20),

              input(titleController, titleNode, 'Title', false),

              space(20),


              isLoadingCategory
            ? loading(blueColor)
            // Profession
            : Container(
                padding: padding(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: borderRadius(5)
                ),
                child: DropdownButton<CategoryModel>(
                  items: [...List.generate(categoryData.length, (index) {
                    return DropdownMenuItem<CategoryModel>(
                      value: categoryData[index],
                      child: Text(categoryData[index].title ?? ''),
                    );
                  })],
                  onChanged: (v) {
                    setState(() {
                      category = v;
                      subCategory = null;
                      getSubCategory(category!);
                    });
                  },
                  isExpanded: true,
                  borderRadius: borderRadius(5),
                  hint: const Text(
                    "Choose Topics"
                  ),
                  value: category, 
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  ),
                  
                  underline: Container(
                   
                  ),
                ),
              ),
             
              space(20),


              isLoadingSubCategory
            ? loading(blueColor)
            // Profession
            : Container(
                padding: padding(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: borderRadius(5)
                ),
                child: DropdownButton<CategoryModel>(
                  items: subCategoryData.map((value) {
                    return DropdownMenuItem<CategoryModel>(
                      value: value,
                      child: Text(value.title ?? ''),
                    );
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      subCategory = v!;
                    });

                  },
                  isExpanded: true,
                  borderRadius: borderRadius(5),
                  hint: const Text(
                    "Choose Sub Topics"
                  ),
                  value: subCategory,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  ),
                  
                  underline: Container(
                   
                  ),
                ),
              ),

              
              
              space(20),

              input(descController, descNode ,'Description', false, line: 5,verticalPadding: 12),

              space(20),

              Center(
                child: button(
                  onTap: () async {

                    if(subCategory == null){
                      return;
                    }

                    if(coverFile == null){
                      return;
                    }

                    if(iconFile == null){
                      return;
                    }

                    if(hexController.text.trim().isEmpty){
                      return;
                    }

                    if(titleController.text.trim().isEmpty){
                      return;
                    }

                    
                    setState(() {
                      isLoading = true;
                    });

                    String? coverPath = await UploadService.upload(coverFile!);
                    String? iconPath = await UploadService.upload(iconFile!);

                    int? id = await ChallengeService.createChallenge(
                      subCategory?.id! ?? category!.id!, 
                      coverPath!, 
                      iconPath!, 
                      hexController.text.trim(), 
                      titleController.text.trim(),
                      descController.text.trim()
                    );

                    if(id != null){
                      context.read<CreateLumProvider>().challengeId = id;
                      nextRoute(AddContentPage(false));
                    }

                    setState(() {
                      isLoading = false;
                    });

                  }, 
                  text: 'Next',
                  bgColor: blueColor, 
                  textColor: Colors.white,
                  isLoading: isLoading
                ),
              ),

              space(40),
            ],
          ),
        ),


      )
    );
  }


  dotButton(Function onTap,String text,){
    return GestureDetector(
      onTap: (){
        onTap();
      },
      behavior: HitTestBehavior.opaque,
      child: DottedBorder(
        color: blueColor,
        strokeWidth: 2,
        radius: const Radius.circular(5),
        dashPattern: const [4, 4],
        borderType: BorderType.RRect,
        child: Container(
          alignment: Alignment.center,
          padding: padding(horizontal: 16),
          width: getSize().width,
          height: 65,
          child: Row(      
            children: [


              const Icon(Icons.add),

              const Spacer(),
              const Spacer(),

              Text(text),

              const Spacer(),const Spacer(),const Spacer(),
              
            ],
          )
        )
      ),
    );
  }

  Widget categoryList(List<String> data , Function(int index) ontap ,int selected){
    return Container(
      width: getSize().width,
      child: Wrap(
        children: [

          ...List.generate(data.length, (index) {
            return GestureDetector(
              onTap: (){
                ontap(index);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: const EdgeInsets.only(right: 4,bottom: 4),
                padding: padding(horizontal: 12,vertical: 6),
                child: Text(
                  data[index],
                  style: TextStyle(
                    color: index == selected ? Colors.white : blueColor,

                  ),
                ),

                decoration: BoxDecoration(
                  color: index == selected ? blueColor : Colors.transparent,
                  border: Border.all(color: blueColor),
                  borderRadius: borderRadius(100)
                ),
              ),
            );
          })
        ],
      ),
    );
  }


}