import 'dart:io';

import 'package:conquerer/models/category_model.dart';
import 'package:conquerer/models/country_model.dart';
import 'package:conquerer/resource/app_resource.dart';
import 'package:conquerer/resource/colors.dart';
import 'package:conquerer/services/auth_service.dart';
import 'package:conquerer/services/base_url.dart';
import 'package:conquerer/services/category_service.dart';
import 'package:conquerer/services/country_service.dart';
import 'package:conquerer/services/upload_service.dart';
import 'package:conquerer/services/user_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../main_pages/main_page.dart';

class InfoPage extends StatefulWidget {
  final bool isProfile;
  const InfoPage({required this.isProfile, Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  
  TextEditingController coNameController = TextEditingController();
  FocusNode coNameNode = FocusNode();

  TextEditingController nameController = TextEditingController();
  FocusNode nameNode = FocusNode();
  TextEditingController familyController = TextEditingController();
  FocusNode familyNode = FocusNode();
  TextEditingController lastDereeController = TextEditingController();
  FocusNode lastDereeNode = FocusNode();
  TextEditingController lastDereeTopicController = TextEditingController();
  FocusNode lastDereeTopicNode = FocusNode();
  TextEditingController voucherCodeController = TextEditingController();
  FocusNode voucherCodeNode = FocusNode();


  final ImagePicker _picker = ImagePicker();
  File? userImage;
  File? professionFile;

  String? countryName;
  String? cityName;
  String? profession;
  

  bool isReal = false;
  bool isLoadingCategory = false;
  bool isLoadingCountry = false;

  bool isLoading = false;

  List<CategoryModel> categoryData = [];
  List<CountryModel> countryData = [];

  String? userImagePath;
  String? degreePhotoPath;


  List<String> lastDegree = [
    'test 1',
    'test 2',
    'test 3',
    'test 4 test',
    'test 5',
  ];
  List<String> lastDegreeTopic = [
    'test 1',
    'test 2',
    'test 3',
    'test 4',
    'test 5',
  ];

  int lastDegreeSelected = 0;
  int lastDegreeTopicSelected = 0;

  String? netImage = '';

  @override
  void initState() {
    super.initState();
    
    getData();
  }

  getData(){

    setState(() {
      isLoadingCategory=true;
      isLoadingCountry=true;
    });

    if(widget.isProfile){
      AuthService.me().then((value) {
        if(value != null){
          nameController.text = value['name'];
          familyController.text = value['family'];
          netImage = value['user_info']['profile_photo'];
          setState(() {});
        }
      });
    }

    CategoryService.getCategory('').then((value) {
      setState(() {
        categoryData = value;
        isLoadingCategory = false;
      });
    });

    CountryService.getCountry().then((value) {
      setState(() {
        countryData = value;
        isLoadingCountry = false;
      });
    });

  }


  selectImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      userImage = File(image.path);
      setState(() {});
    }
  }
  
  selectProfession() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      professionFile = File(image.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: padding(),

          child: Column(
            children: [

              space(80),

              if(widget.isProfile)...{

                Center(
                  child: ClipRRect(
                    borderRadius: borderRadius(100),
                    child: fadeImage(domain + (netImage ?? ''), 80, 80),
                  ),
                ),
                
                space(30),
              },

              Row(
                children: [

                  GestureDetector(
                    onTap: () {
                      selectImage();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: userImage == null
                    ? SvgPicture.asset(AppResource.selectImageSvg,width: 67,height: 67)
                    : ClipRRect(
                        child: Image.file(userImage!,width: 67,height: 67,fit: BoxFit.cover,),
                        borderRadius: borderRadius(100),
                      )
                  ),

                  space(0,width: 24),


                  if(isReal)...{

                    Expanded(
                      child: input(coNameController, coNameNode, 'Company Name', false,),
                    )
                  }else...{

                    Expanded(
                      child: input(nameController, nameNode, 'Name', false,isNextNode: true,nextNode: familyNode),
                    )
                  },

                ],
              ),


              space(24),

              isReal ? Container() : input(familyController, familyNode, 'Family', false),

              space(24),


              isLoadingCountry
            ? loading(blueColor)
            // country
            : Container(
                padding: padding(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: borderRadius(5)
                ),
                child: DropdownButton<String>(
                  items: countryData.map((value) {
                    return DropdownMenuItem<String>(
                      value: value.title,
                      child: Text(value.title ?? ''),
                    );
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      countryName = v;
                    });
                  },
                  isExpanded: true,
                  borderRadius: borderRadius(5),
                  hint: const Text(
                    "Select Country"
                  ),
                  value: countryName,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  ),
                  
                  underline: Container(
                   
                  ),
                ),
              ),

              space(24),


              input(voucherCodeController, voucherCodeNode, 'Voucher Code', false,isNextNode: true,nextNode: lastDereeNode),
              
              space(24),

              input(lastDereeController, lastDereeNode, 'Last Deree', false,isNextNode: true,nextNode: lastDereeTopicNode,hint: 'B.Sc',enabled: false),

              space(8),

              degreeList(lastDegree, (i){
                setState(() {
                  lastDegreeSelected = i;
                });
              },lastDegreeSelected),
              
              space(24),

              input(lastDereeTopicController, lastDereeTopicNode, 'Last Degree Topic', false,isNextNode: true,nextNode: lastDereeTopicNode,hint: 'Physics',enabled: false),

              space(8),

              degreeList(lastDegreeTopic, (i){
                setState(() {
                  lastDegreeTopicSelected = i;
                });
              },lastDegreeTopicSelected),

              space(24),

              Row(
                children: [
                  
                  Expanded(
                    child: button(
                      onTap: (){
                        setState(() {
                          isReal = false;
                        });
                      }, 
                      text: "Personal", 
                      bgColor: isReal ? Colors.transparent : blueColor, 
                      textColor: isReal ? blueColor : Colors.white
                    )
                  ),

                  space(0,width: 12),
                  
                  Expanded(
                    child: button(
                      onTap: (){
                        setState(() {
                          isReal = true;
                        });
                      }, 
                      text: "Legal", 
                      bgColor: isReal ? blueColor : Colors.transparent, 
                      textColor: isReal ? Colors.white : blueColor
                    )
                  ),

                ],
              ),

              space(24),

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
                child: DropdownButton<String>(
                  items: categoryData.map((value) {
                    return DropdownMenuItem<String>(
                      value: value.title,
                      child: Text(value.title ?? ''),
                    );
                  }).toList(),
                  onChanged: (v) {
                    setState(() {
                      profession = v;
                    });
                  },
                  isExpanded: true,
                  borderRadius: borderRadius(5),
                  hint: const Text(
                    "Profession"
                  ),
                  value: profession,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black
                  ),
                  
                  underline: Container(
                   
                  ),
                ),
              ),

              space(8),

              const Text(
                "* Note: By adding profession and it's evidence you become moderator in that topic",
                style: TextStyle(
                  fontSize: 10
                ),
              ),


              space(24),

              // add Profession Evidence widget
              GestureDetector(
                onTap: (){
                  selectProfession();
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
                    height: 48,
                    child: professionFile == null
                      ? Row(      
                          children: const[
              
                            Spacer(),
              
                            Icon(Icons.add),
              
                            Spacer(),
              
                            Text('add Profession Evidence'),
              
                            Spacer(),Spacer(),Spacer(),
                            
                          ],
                        )
                      : Text(basename(professionFile!.path)),
                  )
                ),
              ),

              space(8),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "* Size Limit: 5MB",
                  style: TextStyle(
                    fontSize: 10
                  ),
                ),
              ),

              space(40),

              button(
                onTap: () async {
                  
                  
                  setState(() {
                    isLoading = true;
                  });

                  if(userImage != null){
                    userImagePath = await UploadService.upload(userImage!);
                  }
                  
                  if(professionFile != null){
                    degreePhotoPath = await UploadService.upload(professionFile!);
                  }


                  var res = await UserService.update(
                    nameController.text.trim(), 
                    familyController.text.trim(), 
                    coNameController.text.trim(), 
                    countryName ?? '', 
                    voucherCodeController.text.trim(), 
                    lastDereeController.text.trim(),
                    lastDereeTopicController.text.trim(), 
                    isReal, 
                    profession ?? '', 
                    userImagePath, 
                    degreePhotoPath
                  );

                  if(res){
                    nextRoute(const MainPage(),isClearBackRoutes: true);
                  }
                  
                  setState(() {
                    isLoading = false;
                  });
                  

                }, 
                text: 'finish', 
                bgColor: blueColor, 
                textColor: Colors.white,
                isLoading: isLoading
              ),

              space(30),

            ],
          ),
        ),
      )
    );
  }



  Widget degreeList(List<String> data , Function(int index) ontap ,int selected){
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