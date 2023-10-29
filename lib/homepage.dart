import 'package:flutter/material.dart';
import 'package:flutter_hive/Utils/tasklist.dart';
import 'package:hive/hive.dart';
import 'Utils/constants.dart';
import 'functions.dart';
class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    checkdata();
  }

  HelperFunctions helper = HelperFunctions();
  static final TextEditingController _taskcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()=>_onbackpressed(context),
      child: Scaffold(
        ///APPBAR
        appBar: AppBar(
          elevation: 0,
          title: Text('Notes Keeper'),
          centerTitle: true,
          leading: Icon(Icons.book_online),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: IconButton(onPressed: (){
                opendialogbox(context,(TaskList.tasklist.length+1));
              }, icon: Icon(Icons.add,size: 35,)),
            )

          ],
        ),
        body: Container(
          child: GridView.builder(
              itemCount: TaskList.tasklist.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context,index){
                return TaskCard(
                  id: (TaskList.tasklist[index][0]),
                  taskname: TaskList.tasklist[index][1],
                );
              }),
        ),
      ),
    );
  }




  void opendialogbox(BuildContext context,int idx) async{
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ///TEXTFIELD
                TextField(
                  controller: _HomePageState._taskcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    hintText: 'Add Task',
                  ),

                ),
                ///
                SizedBox(height: 15,),
                ///BUTTONS ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(onPressed:(){
                       ADDDATA(_taskcontroller.text,TaskList.tasklist.length);
                    }, child: Text('Add')),
                    SizedBox(width: 10,),
                    OutlinedButton(onPressed: (){
                      Navigator.of(context).pop(true);
                    }, child: Text('Cancel')),
                  ],
                )
              ],
            ),
          );
        });
  }

  Future<bool>_onbackpressed(BuildContext context) async{
    bool? exitapp = await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Exit ?'),
            content: Text('Are You Sure You Want To Exit ?'),
            actions: [

              OutlinedButton(onPressed: (){
                Navigator.of(context).pop(true);
              }, child: Text('Yes')),
              OutlinedButton(onPressed:(){
                Navigator.of(context).pop(false);
              }, child: Text('No')),
            ],
          );
        });
    return exitapp?? false;
  }

  Future ADDDATA(String text,int id) async {

    var box = Hive.box('MyBox');
    TaskList.tasklist.add([id,text]);
    box.put('MYKEY', TaskList.tasklist);
    List mylist = box.get('MYKEY');
    print('TASKLIST IS $mylist\n');
    _taskcontroller.clear();
    Navigator.of(context).pop(true);
    setState(() {});
  }

   Future checkdata() async{
    var box = Hive.box('MyBox');
    List mylist =await box.get('MYKEY');
    /// IF ITS FIRST TIME
    if(mylist.length==0){
      print('ITS FIRST TIME USER');
      print('DATA NOT EXISTS');
      TaskList.tasklist= TaskList.tasklist;
    }else{
      print('DATA ALREADY EXISTS');
      TaskList.tasklist = mylist;
      print(mylist);
    }
  }
}





