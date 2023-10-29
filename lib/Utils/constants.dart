import 'package:flutter/material.dart';
import 'package:flutter_hive/Utils/tasklist.dart';

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
    return Expanded(
      child: InkWell(
        onLongPress: (){
          showdeletepopup(context,widget.id);
        },
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
    );
  }


  void showdeletepopup(BuildContext context,int id) {
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Delete ?'),
            content: Text('Are You Sure You Want To DeleteThis Item ?'),
            actions: [
              OutlinedButton(onPressed:(){
                Navigator.of(context).pop(true);
              }, child: Text('No')),
              OutlinedButton(onPressed: (){
                    TaskList.tasklist.removeAt(id-1);
                    print('Item Deleted Successfully');
                    Navigator.of(context).pop(true);
                setState(() {
                });
              }, child: Text('Yes')),
            ],
          );
        });
  }
}


