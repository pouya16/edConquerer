import 'package:conquerer/models/vote_model.dart';
import 'package:conquerer/pages/moderating_page/single_moderating_page.dart';
import 'package:conquerer/services/challenge_service.dart';
import 'package:conquerer/widgets/common.dart';
import 'package:flutter/material.dart';

import '../../resource/colors.dart';

class ModeratingPage extends StatefulWidget {
  const ModeratingPage({ Key? key }) : super(key: key);

  @override
  _ModeratingPageState createState() => _ModeratingPageState();
}

class _ModeratingPageState extends State<ModeratingPage> {

  bool isLoading = false;
  List<VoteModel> votes = [];


  @override
  void initState() {
    super.initState();

    getData();
  }


  getData() async {

    setState(() {
      isLoading = true;
    });

    votes = await ChallengeService.getVotes();

    setState(() {
      isLoading = false;
    });

  }


  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: true,
          shadowColor: Colors.grey[200],
          backgroundColor: blueColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          bottomOpacity: 1,
          titleSpacing: 0,
          centerTitle: false,

          title: const Text(
            'Moderating',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ),


        body: isLoading
      ? loading(blueColor)
      : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [

              space(20),

              ...List.generate(votes.length, (index) {
                return listItem(index);
              }),

              isLoading ? loading(blueColor) : Container(),

            ],
          ),
        ) ,

      )
    );
    
  }



  Widget listItem(int index,){
    return GestureDetector(
      onTap: () async {
        bool? res = await navigatorKey.currentState!.push(MaterialPageRoute(builder: (_) => SingleModeratingPage(
          VoteModel.fromJson(votes[index].toJson()),
          getData
        )));

        if(res != null && res){
          getData();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: getSize().width,
        height: 90,
        margin: padding(vertical: 8),
        padding: padding(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  'Lum: ' + (votes[index].title ?? ''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18
                  ),
                ),

                // space(12),

                // const Text(
                //   'Moderation:0/2',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 12
                //   ),
                // ),

              ],
            ),

            // Image.network(
            //   domain + (votes[index].data?.logo ?? ''),
            //   width: 45,
            // ),

          ],
        ),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: borderRadius(25)
        ),
      ),
    );
  }



}