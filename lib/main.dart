import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'homepage.dart';
import 'package:hive/hive.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  var box =await Hive.openBox('MyBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink
      ),
      home: HomePage(),
    );
  }
}




