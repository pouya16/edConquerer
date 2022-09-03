import 'package:conquerer/models/challenge_model.dart';
import 'package:conquerer/models/history_model.dart';
import 'package:conquerer/pages/main_pages/course_page/course_pages_page.dart';
import 'package:conquerer/services/base_url.dart';
import 'package:conquerer/services/user_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({ Key? key }) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> with SingleTickerProviderStateMixin{

  late TabController _tabController;

  List<HistoryModel> data = [];
  List<HistoryModel> inProgressData = [];
  List<HistoryModel> finishedData = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    getData();

  }


  getData() async {

    data = await UserService.inProgress();
    
    for (var item in data) {
      List<String> state = item.progress?.split('/') ?? [];

      if(int.parse(state[0]) < int.parse(state[1])){
        inProgressData.add(item);
      }else{
        finishedData.add(item);
      }
    }

    setState(() {
      
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return directionality(
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
        
              TabBar(
                indicatorColor: Colors.black,
                unselectedLabelColor: Colors.black45,
                labelColor: Colors.black,
                tabs: const [
                 
                  Tab(
                    icon: Text(
                      'In Progress',
                    ),
                  ),

                  Tab(
                    icon: Text(
                      'Finished',
                    ),
                  )
                ],
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    inProgress(),

                    finished(),
                  ]
                )
              )
        
            ],
          ),
        ),
      )
    );
  }


  inProgress(){
    return SingleChildScrollView(
      child: Column(
        children: [
          
          space(20),

          ...List.generate(inProgressData.length, (index) {
            return GestureDetector(
              onTap: (){
                List<String> state = inProgressData[index].progress?.split('/') ?? [];

                nextRoute(
                  CoursePagesPage(
                    ChallengeModel(id: inProgressData[index].id),
                    true,
                    pageId: inProgressData[index].lastPage,
                  )
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Container(

                margin: padding(vertical: 12),
                width: getSize().width,
                height: 110,

                padding: padding(horizontal: 25),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          inProgressData[index].title ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),

                        space(15),
                        
                        Text(
                          'progress: ${inProgressData[index].progress}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),

                        space(6),

                        
                        Text(
                          'elepsad time: ${inProgressData[index].time}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),

                      ],
                    ),

                    fadeImage(domain + (inProgressData[index].data?.icon ?? ''), 40, 40)
                    
                  ],
                ),
    
                decoration: BoxDecoration(
                  color: inProgressData[index].data?.color,
                  borderRadius: borderRadius(25)
                ),

              ),
            );
          }),

        ],
      ),
    );
  
  }
  
  finished(){
    return SingleChildScrollView(
      child: Column(
        children: [
          
          space(20),

          ...List.generate(finishedData.length, (index) {
            return GestureDetector(
              onTap: (){
    
              },
              behavior: HitTestBehavior.opaque,
              child: Container(

                margin: padding(vertical: 12),
                width: getSize().width,
                height: 110,

                padding: padding(horizontal: 25),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Text(
                          finishedData[index].title ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),

                        // space(15),
                        
                        // const Text(
                        //   'points received: ${finishedData[index].po}',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 10,
                        //   ),
                        // ),

                        // space(6),

                        
                        // const Text(
                        //   'category: Computer',
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 10,
                        //   ),
                        // ),

                      ],
                    ),

                    fadeImage(domain + (finishedData[index].data?.icon ?? ''), 40, 40)
                    
                  ],
                ),
    
                decoration: BoxDecoration(
                  color: finishedData[index].data?.color,
                  borderRadius: borderRadius(25)
                ),

              ),
            );
          }),

        ],
      ),
    );
  
  }


}