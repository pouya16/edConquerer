import 'dart:io';

import 'package:conquerer/models/page_model.dart';
import 'package:conquerer/pages/main_pages/design_lum_page/add_question_page.dart';
import 'package:conquerer/pages/main_pages/design_lum_page/image_editor.dart';
import 'package:conquerer/pages/main_pages/design_lum_page/review_page.dart';
import 'package:conquerer/pages/main_pages/design_lum_page/trimmer_page.dart';
import 'package:conquerer/provider/create_lum_provider.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:conquerer/widgets/create_lum_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../resource/colors.dart';

class AddContentPage extends StatefulWidget {
  bool review;
  AddContentPage(this.review,{ Key? key }) : super(key: key);

  @override
  _AddContentPageState createState() => _AddContentPageState();
}

class _AddContentPageState extends State<AddContentPage> {


  final ImagePicker _picker = ImagePicker();

  late CreateLumProvider lumProvider;

  @override
  void initState() {
    super.initState();
    
    init();
  }

  init(){
    lumProvider = Provider.of<CreateLumProvider>(context,listen: false);
  }


  selectVideo(ImageSource source) async {


    final XFile? vio = await _picker.pickVideo(source: source);

    if(vio != null){

      lumProvider.pages[lumProvider.currentPage].video = File(vio.path);

      final fname = await VideoThumbnail.thumbnailFile(
        video: lumProvider.pages[lumProvider.currentPage].video!.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 256,
        quality: 75,
      );

      lumProvider.pages[lumProvider.currentPage].videoCover = fname;

      setState(() {});

    }


  }
  
  selectImage(ImageSource source) async {


    final XFile? im = await _picker.pickImage(source: source);

    if(im != null){

      lumProvider.pages[lumProvider.currentPage].images.add(File(im.path));

      setState(() { });

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(widget.review){
          backRoute();
        }else{
          context.read<CreateLumProvider>().clear();
          backRoute();
          backRoute();
        }
        return false;
      },
      child: directionality(
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
                  width: 30,
                  child: IconButton(
                    onPressed: () {
    
                      if(widget.review){  
                        backRoute();
                      }else{
                        context.read<CreateLumProvider>().clear();
                        backRoute();
                        backRoute();

                      }
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                    padding: padding(horizontal: 0),
                  ),
                ),
    
                const Text(
                  'Add Page ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
    
                const Spacer(),
                
                Text(
                  '${lumProvider.currentPage + 1}/${lumProvider.pages.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
    
                const Spacer(),
                const Spacer(),
                // const Spacer(),
    
                GestureDetector(
                  onTap: (){
                    if(widget.review){
                      backRoute();
                    }else{
                      nextRoute(const ReviewPage());
                    }
                  },
                  child: const Text(
                    'Finish',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                )
                
              ],
            ),
          ),
    
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: padding(),
            child: Column(
              children: [
    
                space(20),
    
                if(lumProvider.pages[lumProvider.currentPage].video != null)...{
    
                  Stack(
                    alignment: Alignment.center,
                    children: [
    
                      AspectRatio(
                        aspectRatio: 16/9,
                        child:  ClipRRect(
                          borderRadius: borderRadius(10),
                          child: Image.file(
                            File(lumProvider.pages[lumProvider.currentPage].videoCover ?? ''),
                            width: getSize().width,
                            fit: BoxFit.cover,
                          ),
                        ),    
                      ),
    
                      Align(
                        alignment: Alignment.center,
                        
                        child: GestureDetector(
                          onTap: () async {
    
                            String? path = await navigatorKey.currentState!.push(MaterialPageRoute(builder: (_)=>TrimmerView(lumProvider.pages[lumProvider.currentPage].video!)));
    
                            if(path != null && path.isNotEmpty){
                              lumProvider.pages[lumProvider.currentPage].video = File(path);
                            }
                          },  
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 150,
                            alignment: Alignment.center,
                            child: const Text(
                              'Tap to Edit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18
                              ),
                            ),
    
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 30,
                                  spreadRadius: 5
                                )
                              ]
                            ),
                          ),
                        ),
                      )
                      
                    ],
                  ),
    
    
                },
    
                space(20),
    
                if(lumProvider.pages[lumProvider.currentPage].texts.isNotEmpty) ...{

                  ...List.generate(lumProvider.pages[lumProvider.currentPage].texts.length, (index) {
                    return Container(
                      margin: padding(vertical: 8,horizontal: 0),
                      padding: padding(horizontal: 16,vertical: 12),
                      width: getSize().width,
      
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          SizedBox(
                            width: 25,
                            child: IconButton(
                              onPressed: (){
                                lumProvider.pages[lumProvider.currentPage].texts.remove(
                                  lumProvider.pages[lumProvider.currentPage].texts[index]
                                );

                                setState(() {});
                              }, 
                              icon: const Icon(Icons.remove_circle_outline)
                            ),
                          ),
      
      
                          TextFormField(
                            controller: lumProvider.pages[lumProvider.currentPage].texts[index],
                            focusNode: FocusNode(),
      
                            maxLines: 10,
                            minLines: 3,
                          )
      
                        ],
                      ),
      
      
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: borderRadius(10),
                        border: Border.all(
                          color: Colors.grey
                        )
                      ),
                    );
                  }),
    
                  
    
                },
    
    
                if(lumProvider.pages[lumProvider.currentPage].images.isNotEmpty)...{

                  space(20),

                  ...List.generate(lumProvider.pages[lumProvider.currentPage].images.length, (index) {
                    return Column(
                      children: [

                        Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
          
                              Image.file(
                                lumProvider.pages[lumProvider.currentPage].images[index],
                                width: getSize().width * .5,
                                fit: BoxFit.fitWidth,
                              ),
          
                              Align(
                                alignment: Alignment.center,
                                
                                child: GestureDetector(
                                  onTap: () async {
          
                                    String? path = await navigatorKey.currentState!.push(MaterialPageRoute(builder: (_)=> ImageEditor(lumProvider.pages[lumProvider.currentPage].images[index])));
          
                                    if(path != null && path.isNotEmpty){
          
                                      lumProvider.pages[lumProvider.currentPage].images[index] = File(path);
          
                                      setState(() {});
                                    }
                                  },  
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: 150,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Tap to Edit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18
                                      ),
                                    ),
          
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 30,
                                          spreadRadius: 5
                                        )
                                      ]
                                    ),
                                  ),
                                ),
                              )
          
                            ],
                          )
                        ),
          
                        space(10),
          
                        IconButton(
                          onPressed: () async {
                            
                            File? croppedFile = await ImageCropper().cropImage(
                              sourcePath: lumProvider.pages[lumProvider.currentPage].images[index].path,
                              aspectRatioPresets: [
                                
                                CropAspectRatioPreset.original,
                                CropAspectRatioPreset.square,
                                CropAspectRatioPreset.ratio3x2,
                                CropAspectRatioPreset.original,
                                CropAspectRatioPreset.ratio4x3,
                                CropAspectRatioPreset.ratio16x9
                              ],
                              // uiSettings: [
                              //   AndroidUiSettings(
                              //       toolbarTitle: 'Cropper',
                              //       toolbarColor: Colors.deepOrange,
                              //       toolbarWidgetColor: Colors.white,
                              //       initAspectRatio: CropAspectRatioPreset.original,
                              //       lockAspectRatio: false),
                              //   IOSUiSettings(
                              //     title: 'Cropper',
                              //   ),
                              // ],
                            );
          
                            if(croppedFile != null){
                              setState(() {
                                lumProvider.pages[lumProvider.currentPage].images[index] = croppedFile;
                              });
                            }
          
          
                          }, 
                          icon: Icon(Icons.crop)
                        ),
          
                        space(10),

                      ],
                    );
                  }),
    
                  
    
                  
                },
                  
    
                space(20),
    
                dotButton(
                  (){
                    CreateLumWidget.componentDialog(
                      onTapVideo: (){
    
                        CreateLumWidget.videoDialog(
                          onTapCamera: (){
                            selectVideo(ImageSource.camera);
                          }, 
                          onTapGallery: (){
                            selectVideo(ImageSource.gallery);
                          }
                        );
    
                      }, 
                      onTapPhoto: (){
    
                        CreateLumWidget.imageDialog(
                          onTapCamera: (){
                            selectImage(ImageSource.camera);
                          }, 
                          onTapGallery: (){
                            selectImage(ImageSource.gallery);
                          }
                        );
    
                      }, 
                      onTapText: (){
                        setState(() {
                          lumProvider.pages[lumProvider.currentPage].texts.add(TextEditingController());
                        });
                      }, 
                      onTapQuestion: (){
                        nextRoute(AddQuestionPage());
                      }
                    );
                  }, 
                  'Add Content'
                ),
    
                space(20),
    
                input(lumProvider.pages[lumProvider.currentPage].linkController, lumProvider.pages[lumProvider.currentPage].linkNode, 'Link', false),
    
                space(120),
              ],
            ),
          ),
    
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: padding(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
    
                FloatingActionButton(
                  backgroundColor: blueColor,
                  heroTag: "btn1",
                  onPressed: (){
                    if(lumProvider.currentPage != 0){
                      lumProvider.currentPage -= 1;
                      setState(() {});
                    }
                  },
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
                
                FloatingActionButton(
                  backgroundColor: blueColor,
                  heroTag: "btn2",
                  onPressed: (){
                    if(lumProvider.currentPage == (lumProvider.pages.length - 1)){
                      lumProvider.pages.add(PageModel());
                      lumProvider.currentPage += 1;
                      setState(() {});
                    }else{
                      lumProvider.currentPage += 1;
                      setState(() {});
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
    
              ],
            ),
          ),
        
        )
      ),
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

}