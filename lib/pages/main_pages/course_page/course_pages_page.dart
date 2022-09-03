import 'package:conquerer/models/challenge_model.dart';
import 'package:conquerer/models/course_page_model.dart';
import 'package:conquerer/pages/main_pages/course_page/start_quiz_page.dart';
import 'package:conquerer/resource/colors.dart';
import 'package:conquerer/services/base_url.dart';
import 'package:conquerer/services/challenge_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CoursePagesPage extends StatefulWidget {
  ChallengeModel challenge;
  bool isHistory;
  int? pageId;
  CoursePagesPage(this.challenge,this.isHistory,{this.pageId ,Key? key }) : super(key: key);

  @override
  _CoursePagesPageState createState() => _CoursePagesPageState();
}

class _CoursePagesPageState extends State<CoursePagesPage> {


  bool isLoading = false;
  int currentPage = -1;

  List<CoursePageModel> pages = [];
  
  VideoPlayerController? _controller;


  @override
  void initState() {
    super.initState();

    if(widget.isHistory){
      getDataHis(widget.pageId!);
    }else{
      getData(widget.challenge.pages!.first);
    }
  }

  initVideo(String video){

    _controller = VideoPlayerController.network(domain + video)
    ..initialize().then((_) {
      _controller!.play();
      
      _controller!.addListener(() {
        setState(() {});
      });
    });

  }

  getDataHis(int id) async {

    setState(() {
      isLoading = true;
    });

    if(widget.challenge.title == null){
      widget.challenge = await ChallengeService.getChallengeDetails(widget.challenge.id!);
      setState(() {});
    }


    List<int> getPageIds = widget.challenge.pages!.getRange(0, (widget.challenge.pages!.indexOf(widget.pageId!) + 1)).toList();

    for (var i = 0; i < getPageIds.length; i++) {
      currentPage++;
      pages.add(await ChallengeService.getFullPageData(widget.challenge.id!, getPageIds[i]));
    }

    if(pages[widget.challenge.pages!.indexOf(widget.pageId!)].data!.video != null){
      initVideo(pages[widget.challenge.pages!.indexOf(widget.pageId!)].data!.video!);
    }
    
    setState(() {
      isLoading = false;
    });

  }

  getData(int id) async {

    setState(() {
      isLoading = true;
    });

    currentPage++;
    
    pages.add(await ChallengeService.getFullPageData(widget.challenge.id!, id));

    if(pages[currentPage].data!.video != null){
      initVideo(pages[currentPage].data!.video!);
    }
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        shadowColor: Colors.grey[200],
        backgroundColor: blueColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        bottomOpacity: 1,
        titleSpacing: 12 ,

        title: Row(
          children: [

            IconButton(onPressed: ()=>  backRoute(), icon:const Icon( Icons.arrow_back_ios_new, color: Colors.white,)),

            Text(
              widget.challenge.title ?? '',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),

            const Spacer(),

            Text(
              '${currentPage + 1} / ${widget.challenge.pages?.length ?? '-'}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            

          ],
        ),
      ),


      body: isLoading
      ? loading(blueColor)
      : SingleChildScrollView(
        padding: padding(),
        child: Column(
          children: [
            space(20),

            pageWidget(pages[currentPage]),

            space(20),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: padding(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            if(currentPage!=0)...{
              FloatingActionButton(
                backgroundColor: blueColor,
                heroTag: "btn1",
                onPressed: (){


                  if(currentPage != 0){
                    _controller=null;
                    currentPage--;
                    if(pages[currentPage].data!.video != null){
                      initVideo(pages[currentPage].data!.video!);
                    }
                    setState(() {});
                  }
                },
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            }else...{
              space(0),
            },

            
            if(currentPage != ( (widget.challenge.pages?.length ?? 0) -1 ))...{
              FloatingActionButton(
                backgroundColor: blueColor,
                heroTag: "btn2",
                onPressed: (){
                
                  if(currentPage < (widget.challenge.pages!.length - 1)){

                    if(pages.length < (widget.challenge.pages!.length) ){
                      _controller=null;
                      getData(widget.challenge.pages![currentPage+1]);
                      setState(() {});
                    }else{
                      if(pages.length == (widget.challenge.pages!.length)){
                        currentPage++;
                        setState(() {});
                      }
                    }

                  }
                },
                child: const Icon(Icons.arrow_forward_ios),
              ),
            }

          ],
        ),
      ),
    

    );
  }


  Widget pageWidget(CoursePageModel page){
    return Column(
      children: [
        
        if(_controller != null) ...{
          if(_controller!.value.isInitialized)...{
            Stack(
              children: [

                GestureDetector(
                  onTap: (){
                    if(_controller!.value.isPlaying){
                      _controller!.pause();
                    }else{
                      _controller!.play();
                    }

                    setState(() {});
                  },
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(_controller!),
                  ),
                ),  

                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: IgnorePointer(
                    child: Icon(
                      _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
              
            ),

          },  
          
        },
        
        space(20),

        ...List.generate(page.data?.texts?.length ?? 0, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              page.data?.texts?[index] ?? '',
            ),
          );
        }),
        
        ...List.generate(page.data?.images?.length ?? 0, (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              domain + (page.data?.images?[index] ?? ''),
            ),
          );
        }),


        space(10),

        if(page.data?.link != null)...{
          SelectableText( 
            "Link : " + (page.data?.link ?? '')
          ),
        },

        if(page.data!.quizId != null)...{
          space(30),

          button(
            onTap: () async {
              page.isStartQuiz = true;

              bool? res = await navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => StartQuizPage(widget.challenge, page)));

              if(res != null && res){
                page.isFinishedQuiz = true;
              }
            }, 
            text: 'Start', 
            bgColor: blueColor, 
            textColor: Colors.white
          )
        }

      ],
    );
  }


  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}