import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hive/Utils/tasklist.dart';
import 'package:hive/hive.dart';

class TaskCard extends StatefulWidget {
   final int id ;
   final String taskname;
   TaskCard({super.key,required this.taskname,required this.id});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
              // showdeletepopup(context,widget.id);
            child: Container(
              child: Card(
                margin: EdgeInsets.all(8.0),
                color: Colors.white70,
                child: Center(
                    child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(widget.taskname,
                            style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                        ))),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //
  // void showdeletepopup(BuildContext context,int id) {
  //   print('INDEX IS $id');
  //   showDialog(
  //       context: context,
  //       builder: (context){
  //         return AlertDialog(
  //           title: Text('Delete ?'),
  //           content: Text('Are You Sure You Want To Mark This Task As Complete ?'),
  //           actions: [
  //             OutlinedButton(onPressed:(){
  //               Navigator.of(context).pop(true);
  //             }, child: Text('No')),
  //             OutlinedButton(onPressed: (){
  //               List templist = [];
  //               Timer(Duration(seconds: 5), () {
  //                      TaskList.tasklist=templist;
  //                      var box = Hive.box('MyBox');
  //                      box.put('MYKEY', TaskList.tasklist);
  //                      print('TASKLIST IS ${TaskList.tasklist}');
  //               });
  //               ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleting Item ')));
  //               for(int i=0;i<TaskList.tasklist.length;i++){
  //                 if(TaskList.tasklist[i][0]!=id){
  //                   templist.add([TaskList.tasklist[i][0],TaskList.tasklist[i][1]]);
  //                  }
  //               }
  //               Navigator.pop(context);
  //               setState(() {
  //
  //               });
  //             }, child: Text('Yes')),
  //           ],
  //         );
  //       });
  // }


}


